defmodule BananaBank.Users do
  alias BananaBank.Users.Update
  alias BananaBank.Users.Get
  alias BananaBank.Users.Create

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate update(params), to: Update, as: :call
end
