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
  end
end
