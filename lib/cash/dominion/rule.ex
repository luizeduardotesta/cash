defmodule Cash.Dominion.Rule do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rules" do
    field :bonus, :integer
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(rule, attrs) do
    rule
    |> cast(attrs, [:description, :bonus])
    |> validate_required([:description, :bonus])
  end
end
