defmodule BananaBankWeb.WelcomeController do
  use BananaBankWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{
      message: "Welcome to Banana Bank API",
      status: :ok
    })
  end
end
