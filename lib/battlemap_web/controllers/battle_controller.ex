defmodule BattlemapWeb.BattleController do
  use BattlemapWeb, :controller

  alias Battlemap.Main
  alias Battlemap.Main.Battle

  action_fallback BattlemapWeb.FallbackController

  def index(conn, _params) do
    battles = Main.list_battles()
    render(conn, "index.json", battles: battles)
  end
end
