defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  import Mox

  alias BananaBank.Users
  alias Users.User
  alias BananaBank.ViaCep

  setup do
    params = %{
      "name" => "John Doe",
      "email" => "john@email.com",
      "cep" => "01001000",
      "password" => "password123"
    }

    body =
      %{
        "bairro" => "Sé",
        "cep" => "01001-000",
        "complemento" => "lado ímpar",
        "ddd" => "11",
        "estado" => "São Paulo",
        "gia" => "1004",
        "ibge" => "3550308",
        "localidade" => "São Paulo",
        "logradouro" => "Praça da Sé",
        "regiao" => "Sudeste",
        "siafi" => "7107",
        "uf" => "SP",
        "unidade" => ""
      }

    {:ok, %{user_params: params, body: body}}
  end

  describe "create/2" do
    test "successfully creates an user", %{conn: conn, user_params: params, body: body} do
      expect(ViaCep.ClientMock, :call, fn "01001000" ->
        {:ok, body}
      end)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert %{
               "data" => %{
                 "cep" => "01001000",
                 "email" => "john@email.com",
                 "id" => _id,
                 "name" => "John Doe"
               },
               "message" => "User created successfully"
             } = response
    end

    test "when there are invalid body, returns an error", %{conn: conn, body: body} do
      params = %{
        name: "John Doe",
        email: "invalid_email",
        cep: "01001000",
        password: "password123"
      }

      expect(ViaCep.ClientMock, :call, fn "01001000" ->
        {:ok, body}
      end)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:unprocessable_entity)

      expected_response = %{
        "errors" => %{
          "email" => ["has invalid format"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "successfully deletes an user", %{conn: conn, user_params: params, body: body} do
      expect(ViaCep.ClientMock, :call, fn "01001000" ->
        {:ok, body}
      end)

      {:ok, %User{id: id}} = Users.create(params)

      conn
      |> delete(~p"/api/users/#{id}")
      |> json_response(:no_content)
    end
  end
end
