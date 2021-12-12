defmodule CashWeb.RuleController do
  use CashWeb, :controller

  def create(conn, params) do
    {:ok, rule} = Cash.Dominion.create_rule(params)

    conn
    |> put_status(201)
    |> json(%{data: %{description: rule.description, bonus: rule.bonus, id: rule.id}})
  end
end
