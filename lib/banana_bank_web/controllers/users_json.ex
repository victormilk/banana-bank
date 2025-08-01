defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User

  def create(%{user: %User{} = user}) do
    %{
      message: "User created successfully",
      data: data(user)
    }
  end

  def login(%{token: token}) do
    %{
      message: "User logged in successfully",
      data: %{
        token: token
      }
    }
  end

  def show(%{user: %User{} = user}) do
    %{
      message: "User retrieved successfully",
      data: user
    }
  end

  def update(%{user: %User{} = user}) do
    %{
      message: "User updated successfully",
      data: data(user)
    }
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      cep: user.cep
    }
  end
end
