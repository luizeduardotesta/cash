defmodule Cash.Repo.Migrations.CreateRules do
  use Ecto.Migration

  def change do
    create table(:rules) do
      add :description, :string
      add :bonus, :integer

      timestamps()
    end
  end
end
