defmodule BattlemapWeb.PageControllerTest do
  use BattlemapWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "BattleMap"
  end
end
