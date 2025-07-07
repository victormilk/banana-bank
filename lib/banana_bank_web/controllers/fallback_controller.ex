defmodule BananaBankWeb.FallbackController do
  use BananaBankWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BananaBankWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
