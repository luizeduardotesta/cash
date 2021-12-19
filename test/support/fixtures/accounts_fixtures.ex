defmodule Cash.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cash.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        cpf: "some cpf",
        email: "some email",
        name: "some name",
        password: "some password"
      })
      |> Cash.Accounts.create_user()

    user
  end
end
