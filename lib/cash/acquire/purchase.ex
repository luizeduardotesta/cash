defmodule Cash.Acquire.Purchase do
  use Ecto.Schema
  import Ecto.Changeset

  schema "purchases" do
    field :price, :integer
    field :purchase_code, :integer
    field :user_cpf, :string

    belongs_to :rule, Cash.Dominion.Rule

    timestamps()
  end

  @required [:price, :purchase_code, :user_cpf, :rule_id]
  @doc false
  def changeset(purchase, attrs) do
    purchase
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> validate_number(:price, greater_than: 0)
    |> validate_user_cpf()
  end

  defp validate_user_cpf(changeset) do
    validate_change(changeset, :user_cpf, fn _, user_cpf ->
      case Regex.run(~r/^\d{3}.\d{3}.\d{3}-\d{2}$/, user_cpf) do
        nil -> [user_cpf: "invalid user_cpf format"]
        [_] -> []
      end
    end)
  end
end
