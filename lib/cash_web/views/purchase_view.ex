defmodule CashWeb.PurchaseView do
  use CashWeb, :view

  def render("show.json", %{purchase: purchase}) do
    %{data: render_one(purchase, __MODULE__, "purchase.json")}
  end

  def render("index.json", %{purchases: purchases}) do
    %{data: render_many(purchases, __MODULE__, "purchase.json")}

  end

  def render("purchase.json", %{purchase: purchase}) do
  #  purchase = Cash.Repo.preload(purchase, [:rule])
    %{
      price: purchase.price,
      purchase_code: purchase.purchase_code,
      user_cpf: purchase.user_cpf,
      rule_id: purchase.rule_id,
      id: purchase.id
    }
  end
end
