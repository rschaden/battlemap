defmodule BattlemapWeb.BattleController do
  use BattlemapWeb, :controller

  alias Battlemap.Main
  alias Battlemap.Main.Battle

  action_fallback BattlemapWeb.FallbackController

  def index(conn, %{ "filter" => %{ "earliestDate" => earliest_date, "latestDate" => latest_date }}) do
    battles = Main.search_battles(earliest_date, latest_date)
    render(conn, "index.json", battles: battles)
  end

  def index(conn, _params) do
    battles = Main.list_battles()
    render(conn, "index.json", battles: battles)
  end
end
