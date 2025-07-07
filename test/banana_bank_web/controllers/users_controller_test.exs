defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  alias BananaBank.Users
  alias Users.User

  describe "create/2" do
    test "successfully creates an user", %{conn: conn} do
      body = %{
        name: "John Doe",
        email: "john@email.com",
        cep: "12345678",
        password: "password123"
      }

      response =
        conn
        |> post(~p"/api/users", body)
        |> json_response(:created)

      assert %{
               "data" => %{
                 "cep" => "12345678",
                 "email" => "john@email.com",
                 "id" => _id,
                 "name" => "John Doe"
               },
               "message" => "User created successfully"
             } = response
    end

    test "when there are invalid body, returns an error", %{conn: conn} do
      body = %{
        name: "John Doe",
        email: "invalid_email",
        cep: "12345678",
        password: "password123"
      }

      response =
        conn
        |> post(~p"/api/users", body)
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
    test "successfully deletes an user", %{conn: conn} do
      params = %{
        name: "John Doe",
        email: "john@email.com",
        cep: "12345678",
        password: "password123"
      }

      {:ok, %User{id: id}} = Users.create(params)

      conn
      |> delete(~p"/api/users/#{id}")
      |> json_response(:no_content)
    end
  end
end
