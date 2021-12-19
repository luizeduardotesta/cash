defmodule Cash.AcquireTest do
  use Cash.DataCase

  import Cash.Factory

  alias Cash.Acquire

  describe "purchases" do
    alias Cash.Acquire.Purchase

    @invalid_attrs %{price: nil, purchase_code: nil, user_cpf: nil}

    test "list_purchases/0 returns all purchases" do
      purchase = insert(:purchase)
      assert [subject] = Acquire.list_purchases()
      assert subject.id == purchase.id
    end

    test "get_purchase!/1 returns the purchase with given id" do
      purchase = insert(:purchase)
      assert subject = Acquire.get_purchase!(purchase.id)
      assert subject.id == purchase.id
    end

    test "create_purchase/1 with valid data creates a purchase" do
      valid_attrs = params_with_assocs(:purchase)

      assert {:ok, %Purchase{} = purchase} = Acquire.create_purchase(valid_attrs)
      assert purchase.price == valid_attrs.price
      assert purchase.purchase_code == valid_attrs.purchase_code
      assert purchase.user_id == valid_attrs.user_id
    end

    test "create_purchase/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Acquire.create_purchase(@invalid_attrs)
    end

    test "update_purchase/2 with valid data updates the purchase" do
      purchase = insert(:purchase)
      update_attrs = %{price: 43, purchase_code: 43}

      assert {:ok, %Purchase{} = purchase} = Acquire.update_purchase(purchase, update_attrs)
      assert purchase.price == update_attrs.price
      assert purchase.purchase_code == update_attrs.purchase_code
    end

    test "update_purchase/2 with invalid data returns error changeset" do
      purchase = insert(:purchase)
      assert {:error, %Ecto.Changeset{}} = Acquire.update_purchase(purchase, @invalid_attrs)
    end

    test "delete_purchase/1 deletes the purchase" do
      purchase = insert(:purchase)
      assert {:ok, %Purchase{}} = Acquire.delete_purchase(purchase)
      assert_raise Ecto.NoResultsError, fn -> Acquire.get_purchase!(purchase.id) end
    end

    test "change_purchase/1 returns a purchase changeset" do
      purchase = insert(:purchase)
      assert %Ecto.Changeset{} = Acquire.change_purchase(purchase)
    end
  end
end
