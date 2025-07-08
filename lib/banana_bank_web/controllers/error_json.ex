defmodule BananaBankWeb.ErrorJSON do
  alias Ecto.Changeset

  def error(%{changeset: changeset = %Changeset{}}) do
    %{
      errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
    }
  end

  def error(%{status: :not_found}) do
    %{
      status: :not_found,
      error: "Resource not found"
    }
  end

  def error(%{status: :bad_request}) do
    %{
      status: :bad_request,
      error: "Bad request"
    }
  end

  def error(%{message: message}) do
    %{
      message: to_string(message)
    }
  end

  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  defp translate_error({msg, opts}) do
    Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
      opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
    end)
  end
end
