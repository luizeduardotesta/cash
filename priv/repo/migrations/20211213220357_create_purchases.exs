defmodule Cash.Repo.Migrations.CreatePurchases do
  use Ecto.Migration

  def change do
    create table(:purchases) do
      add :purchase_code, :integer
      add :user_cpf, :string
      add :price, :integer
      add :rule_id, references(:rules, on_delete: :nothing)

      timestamps()
    end

    create index(:purchases, [:rule_id])
  end
end
