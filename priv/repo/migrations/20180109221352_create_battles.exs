defmodule Battlemap.Repo.Migrations.CreateBattles do
  use Ecto.Migration

  def change do
    create table(:battles) do
      add :name, :text
      add :start_date, :date
      add :end_date, :date

      timestamps()
    end

    execute("SELECT AddGeometryColumn ('battles','location',4326,'POINT',2);")
  end

  def down do
    drop table(:battles)
  end
end
