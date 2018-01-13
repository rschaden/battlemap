defmodule BattlemapWeb.PageController do
  use BattlemapWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", api_key: System.get_env("GOOGLE_API_KEY")
  end
end
