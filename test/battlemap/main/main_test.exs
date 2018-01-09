defmodule Battlemap.MainTest do
  use Battlemap.DataCase

  alias Battlemap.Main

  describe "battles" do
    alias Battlemap.Main.Battle

    @valid_attrs %{end_date: ~D[2010-04-17], location: "some location", name: "some name", start_date: ~D[2010-04-17]}
    @update_attrs %{end_date: ~D[2011-05-18], location: "some updated location", name: "some updated name", start_date: ~D[2011-05-18]}
    @invalid_attrs %{end_date: nil, location: nil, name: nil, start_date: nil}

    def battle_fixture(attrs \\ %{}) do
      {:ok, battle} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Main.create_battle()

      battle
    end

    test "list_battles/0 returns all battles" do
      battle = battle_fixture()
      assert Main.list_battles() == [battle]
    end

    test "get_battle!/1 returns the battle with given id" do
      battle = battle_fixture()
      assert Main.get_battle!(battle.id) == battle
    end

    test "create_battle/1 with valid data creates a battle" do
      assert {:ok, %Battle{} = battle} = Main.create_battle(@valid_attrs)
      assert battle.end_date == ~D[2010-04-17]
      assert battle.location == "some location"
      assert battle.name == "some name"
      assert battle.start_date == ~D[2010-04-17]
    end

    test "create_battle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Main.create_battle(@invalid_attrs)
    end

    test "update_battle/2 with valid data updates the battle" do
      battle = battle_fixture()
      assert {:ok, battle} = Main.update_battle(battle, @update_attrs)
      assert %Battle{} = battle
      assert battle.end_date == ~D[2011-05-18]
      assert battle.location == "some updated location"
      assert battle.name == "some updated name"
      assert battle.start_date == ~D[2011-05-18]
    end

    test "update_battle/2 with invalid data returns error changeset" do
      battle = battle_fixture()
      assert {:error, %Ecto.Changeset{}} = Main.update_battle(battle, @invalid_attrs)
      assert battle == Main.get_battle!(battle.id)
    end

    test "delete_battle/1 deletes the battle" do
      battle = battle_fixture()
      assert {:ok, %Battle{}} = Main.delete_battle(battle)
      assert_raise Ecto.NoResultsError, fn -> Main.get_battle!(battle.id) end
    end

    test "change_battle/1 returns a battle changeset" do
      battle = battle_fixture()
      assert %Ecto.Changeset{} = Main.change_battle(battle)
    end
  end
end
