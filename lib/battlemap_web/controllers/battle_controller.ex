defmodule BattlemapWeb.BattleController do
  use BattlemapWeb, :controller

  alias Battlemap.Main
  alias Battlemap.Main.Battle

  def index(conn, _params) do
    battles = Main.list_battles()
    render(conn, "index.html", battles: battles)
  end

  def new(conn, _params) do
    changeset = Main.change_battle(%Battle{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"battle" => battle_params}) do
    case Main.create_battle(battle_params) do
      {:ok, battle} ->
        conn
        |> put_flash(:info, "Battle created successfully.")
        |> redirect(to: battle_path(conn, :show, battle))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    battle = Main.get_battle!(id)
    render(conn, "show.html", battle: battle)
  end

  def edit(conn, %{"id" => id}) do
    battle = Main.get_battle!(id)
    changeset = Main.change_battle(battle)
    render(conn, "edit.html", battle: battle, changeset: changeset)
  end

  def update(conn, %{"id" => id, "battle" => battle_params}) do
    battle = Main.get_battle!(id)

    case Main.update_battle(battle, battle_params) do
      {:ok, battle} ->
        conn
        |> put_flash(:info, "Battle updated successfully.")
        |> redirect(to: battle_path(conn, :show, battle))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", battle: battle, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    battle = Main.get_battle!(id)
    {:ok, _battle} = Main.delete_battle(battle)

    conn
    |> put_flash(:info, "Battle deleted successfully.")
    |> redirect(to: battle_path(conn, :index))
  end
end
