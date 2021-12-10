defmodule Cash.DominionTest do
  use Cash.DataCase

  import Cash.Factory

  alias Cash.Dominion

  describe "rules" do
    alias Cash.Dominion.Rule

    @invalid_attrs %{bonus: nil, description: nil}

    test "list_rules/0 returns all rules" do
      rule = insert(:rule)
      assert Dominion.list_rules() == [rule]
    end

    test "get_rule!/1 returns the rule with given id" do
      rule = insert(:rule)
      assert Dominion.get_rule!(rule.id) == rule
    end

    test "create_rule/1 with valid data creates a rule" do
      valid_attrs = params_for(:rule)

      assert {:ok, %Rule{} = rule} = Dominion.create_rule(valid_attrs)
      assert rule.bonus == valid_attrs.bonus
      assert rule.description == valid_attrs.description
    end

    test "create_rule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dominion.create_rule(@invalid_attrs)
    end

    test "update_rule/2 with valid data updates the rule" do
      rule = insert(:rule)
      update_attrs = %{bonus: 43, description: "some updated description"}

      assert {:ok, %Rule{} = rule} = Dominion.update_rule(rule, update_attrs)
      assert rule.bonus == 43
      assert rule.description == "some updated description"
    end

    test "update_rule/2 with invalid data returns error changeset" do
      rule = insert(:rule)
      assert {:error, %Ecto.Changeset{}} = Dominion.update_rule(rule, @invalid_attrs)
      assert rule == Dominion.get_rule!(rule.id)
    end

    test "delete_rule/1 deletes the rule" do
      rule = insert(:rule)
      assert {:ok, %Rule{}} = Dominion.delete_rule(rule)
      assert_raise Ecto.NoResultsError, fn -> Dominion.get_rule!(rule.id) end
    end

    test "change_rule/1 returns a rule changeset" do
      rule = insert(:rule)
      assert %Ecto.Changeset{} = Dominion.change_rule(rule)
    end
  end
end
