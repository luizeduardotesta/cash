defmodule Cash.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :cpf, :string
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :cpf])
    |> validate_required([:name, :email, :password, :cpf])
    |> validate_length(:password, min: 6)
    |> validate_cpf()
    |> validate_email()
  end

  defp validate_cpf(changeset) do
    validate_change(changeset, :cpf, fn _, cpf ->
      case Regex.run(~r/^\d{3}.\d{3}.\d{3}-\d{2}$/, cpf) do
        nil -> [cpf: "invalid cpf format"]
        [_] -> []
      end
    end)
  end

  defp validate_email(changeset) do
    validate_change(changeset, :email, fn _, email ->
      case Regex.run(~r/^[A-Za-z0-9.%+-+']+@[A-Za-z0-9.-]/, email) do
        nil -> [email: "invalid email format"]
        [_] -> []
      end
    end)
  end
end
