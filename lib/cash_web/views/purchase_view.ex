defmodule CashWeb.PurchaseView do
  use CashWeb, :view

  alias Cash.Acquire
  alias Cash.Repo

  def render("show.json", %{purchase: purchase}) do
    %{data: render_one(purchase, __MODULE__, "purchase.json")}
  end

  def render("index.json", %{purchases: purchases}) do
    %{data: render_many(purchases, __MODULE__, "purchase.json")}

  end

  def render("purchase.json", %{purchase: purchase}) do
    purchase = Cash.Repo.preload(purchase, [:user])

    %{
      price: purchase.price,
      purchase_code: purchase.purchase_code,
      user_cpf: purchase.user.cpf,
      rule_id: purchase.rule_id,
      id: purchase.id
    }
  end

  def render("code.json", %{purchase: purchase}) do
    purchase = Repo.preload(purchase, :rule)
    purchase = Repo.preload(purchase, :user)

    %{
      data: %{
        value: Acquire.calc_cashback(purchase.price, purchase.rule.bonus),
        code: Acquire.gen_code(purchase.id, purchase.user.cpf)
      }
    }
  end
end
