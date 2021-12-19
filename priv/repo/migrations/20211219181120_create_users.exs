defmodule Cash.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :password, :string
      add :cpf, :string

      timestamps()
    end
  end
end
