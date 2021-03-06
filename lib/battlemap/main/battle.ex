defmodule Battlemap.Main.Battle do
  use Ecto.Schema
  import Ecto.Changeset
  alias Battlemap.Main.Battle


  schema "battles" do
    field :end_date, :date
    field :location, Geo.Point
    field :name, :string
    field :start_date, :date

    timestamps()
  end

  @doc false
  def changeset(%Battle{} = battle, attrs) do
    battle
    |> cast(attrs, [:name, :start_date, :end_date, :location])
    |> validate_required([:name, :start_date, :end_date, :location])
  end
end
