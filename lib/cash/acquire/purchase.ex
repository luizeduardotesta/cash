defmodule Cash.Acquire.Purchase do
  use Ecto.Schema
  import Ecto.Changeset

  schema "purchases" do
    field :price, :integer
    field :purchase_code, :integer

    belongs_to :rule, Cash.Dominion.Rule
    belongs_to :user, Cash.Accounts.User

    timestamps()
  end

  @required [:price, :purchase_code, :rule_id, :user_id]
  @doc false
  def changeset(purchase, attrs) do
    purchase
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> validate_number(:price, greater_than: 0)
  end
end
