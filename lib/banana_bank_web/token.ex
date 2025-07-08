defmodule BananaBankWeb.Token do
  alias BananaBank.Users.User
  alias BananaBankWeb.Endpoint
  alias Phoenix.Token

  @sign_salt "banana_bank_token_salt"

  def sign(user), do: Token.sign(Endpoint, @sign_salt, %{user_id: user.id})

  def verify(token), do: Token.verify(Endpoint, @sign_salt, token)
end
