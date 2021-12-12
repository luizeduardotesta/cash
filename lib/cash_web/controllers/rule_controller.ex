defmodule CashWeb.RuleController do
  use CashWeb, :controller

  alias Cash.Dominion.Rule

  action_fallback CashWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Rule{} = rule} <- Cash.Dominion.create_rule(params) do

      conn
      |> put_status(201)
      |> render("show.json", rule: rule)
    end
  end
end
