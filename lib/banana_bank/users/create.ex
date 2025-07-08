defmodule BananaBank.Users.Create do
  alias BananaBank.Users.User
  alias BananaBank.Repo
  alias BananaBank.ViaCep

  def call(%{"cep" => cep} = params) do
    with {:ok, _} <- client().call(cep) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end

  defp client() do
    Application.get_env(:banana_bank, :via_cep_client, ViaCep.Client)
  end
end
