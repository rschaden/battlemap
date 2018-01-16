defmodule BattlemapWeb.BattleControllerTest do
  use BattlemapWeb.ConnCase

  alias Battlemap.Main
  alias Battlemap.Main.Battle

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:battle) do
    {:ok, battle} = Main.create_battle(@create_attrs)
    battle
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all battles", %{conn: conn} do
      conn = get conn, battle_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end
end

