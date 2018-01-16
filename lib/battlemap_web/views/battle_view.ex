defmodule BattlemapWeb.BattleView do
  use BattlemapWeb, :view
  alias BattlemapWeb.BattleView

  def render("index.json", %{battles: battles}) do
    %{data: render_many(battles, BattleView, "battle.json")}
  end

  def render("battle.json", %{battle: battle}) do
    coordinates = battle.location.coordinates

    %{id: battle.id,
      name: battle.name,
      start_date: battle.start_date,
      end_date: battle.end_date,
      location: %{lat: elem(coordinates, 1), lng: elem(coordinates, 0)}}
  end
end
