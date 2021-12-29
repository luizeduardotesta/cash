defmodule CashWeb.PurchaseController do
  use CashWeb, :controller

  alias Cash.Acquire.Purchase

  action_fallback CashWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Purchase{} = purchase} <- Cash.Acquire.create_purchase(params) do
      conn
      |> put_status(201)
      |> render("show.json", purchase: purchase)
    end
  end

  def index(conn, _params) do
    conn
    |>render("index.json", purchases: Cash.Acquire.list_purchases())
  end

  def cashback_code(conn, params) do
    conn
    |> put_status(201)
    |> render("code.json", purchase: Cash.Acquire.get_purchase!(params["id"]))
  end
end
