defmodule BananaBank.Accounts.Transaction do
  alias Ecto.Multi
  alias BananaBank.Accounts
  alias Accounts.Account
  alias BananaBank.Repo

  @spec call(any()) :: {:error, any()} | {:ok, any()}
  def call(%{"from_account_id" => from_account_id, "to_account_id" => to_account_id, "value" => value}) do
    with {:ok, value} <- Decimal.cast(value),
         %Account{} = from_account <- Repo.get(Account, from_account_id),
         %Account{} = to_account <- Repo.get(Account, to_account_id) do
      Multi.new()
      |> withdraw(from_account, value)
      |> deposit(to_account, value)
      |> Repo.transact()
      |> handle_transaction()
    else
      :error -> {:error, :invalid_value}
      nil -> {:error, :not_found}
    end
  end

  def call(_), do: {:error, :invalid_params}

  defp deposit(multi, %Account{} = to_account, value) do
    new_balance = Decimal.add(to_account.balance, value)
    changeset = Account.changeset(to_account, %{balance: new_balance})
    Multi.update(multi, :deposit, changeset)
  end

  defp withdraw(multi, %Account{} = from_account, value) do
    new_balance = Decimal.sub(from_account.balance, value)
    changeset = Account.changeset(from_account, %{balance: new_balance})
    Multi.update(multi, :withdraw, changeset)
  end

  defp handle_transaction({:ok, _} = result), do: result

  defp handle_transaction({:error, _, reason, _}), do: {:error, reason}
end
