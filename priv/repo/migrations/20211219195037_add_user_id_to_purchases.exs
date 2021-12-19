defmodule Cash.Repo.Migrations.AddUserIdToPurchases do
  use Ecto.Migration

  def change do
    alter table(:purchases) do
      add :user_id, references(:users, on_delete: :nilify_all)
    end
  end
end
