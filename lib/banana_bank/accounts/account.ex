defmodule BananaBank.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias BananaBank.Users.User

  @required_fields [:balance, :user_id]

  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User

    timestamps()
  end

  def changeset(account \\ %__MODULE__{}, params) do
    account
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> check_constraint(:balance, name: :balance_must_be_positive, message: "must be positive")
    |> unique_constraint(:user_id, name: :accounts_user_id_index, message: "already has an account")
  end
end
