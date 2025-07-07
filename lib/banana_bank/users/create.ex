defmodule BananaBank.Users.Create do
  alias BananaBank.Users.User
  alias BananaBank.Repo
  alias BananaBank.ViaCep

  def call(%{"cep" => cep} = params) do
    with {:ok, _} <- ViaCep.Client.call(cep) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end
end
