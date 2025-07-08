defmodule BananaBank.Users.Verify do
  alias BananaBank.Users
  alias Users.User

  def call(%{"email" => email, "password" => password}) do
    case Users.get_by_email(email) do
      {:ok, user} -> verify(user, password)
      {:error, _} = error -> error
    end
  end

  defp verify(%User{} = user, password) do
    case Argon2.verify_pass(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, :unauthorized}
    end
  end
end
