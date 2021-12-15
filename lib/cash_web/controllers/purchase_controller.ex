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
end