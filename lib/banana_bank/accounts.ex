defmodule BananaBank.Accounts do
  alias BananaBank.Accounts.Transaction
  alias BananaBank.Accounts.Create

  defdelegate create(params), to: Create, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
end
