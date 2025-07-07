defmodule BananaBankWeb.FallbackController do
  use BananaBankWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BananaBankWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(BananaBankWeb.ErrorJSON)
    |> render(:error, status: :not_found)
  end
end
