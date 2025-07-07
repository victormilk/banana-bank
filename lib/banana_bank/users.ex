defmodule BananaBank.Users do
  alias BananaBank.Users.Get
  alias BananaBank.Users.Create

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
end
