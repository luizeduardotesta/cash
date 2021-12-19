defmodule Cash.AccountsTest do
  use Cash.DataCase

  import Cash.Factory

  alias Cash.Accounts

  describe "users" do
    alias Cash.Accounts.User

    @invalid_attrs %{cpf: nil, email: nil, name: nil, password: nil}

    test "list_users/0 returns all users" do
      user = insert(:user)
      assert [subject] = Accounts.list_users()
      assert subject.id == user.id
    end

    test "get_user!/1 returns the user with given id" do
      user = insert(:user)
      assert subject = Accounts.get_user!(user.id)
      assert subject.id == user.id
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = params_for(:user)

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.cpf == valid_attrs.cpf
      assert user.email == valid_attrs.email
      assert user.name == valid_attrs.name
      assert user.password == valid_attrs.password
    end

    test "return a error when invalid cpf" do
      invalid_attrs = %{cpf: "1234567900"}

      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(invalid_attrs)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = insert(:user)

      update_attrs = %{
        cpf: "159.753.987-45",
        email: Faker.Internet.email(),
        name: "some updated name",
        password: "some updated password"
      }

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.cpf == update_attrs.cpf
      assert user.email == update_attrs.email
      assert user.name == update_attrs.name
      assert user.password == update_attrs.password
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = insert(:user)
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
    end

    test "delete_user/1 deletes the user" do
      user = insert(:user)
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = insert(:user)
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
