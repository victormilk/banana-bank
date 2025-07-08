defmodule BananaBank.Accounts.Create do
  alias BananaBank.Users.User
  alias BananaBank.Accounts.Account
  alias BananaBank.Repo

  def call(%{"user_id" => user_id} = params) do
    case Repo.get(User, user_id) do
      nil ->
        {:error, :not_found}

      _ ->
        params
        |> Account.changeset()
        |> Repo.insert()
    end
  end
end
