defmodule CashWeb.RuleView do
  use CashWeb, :view

  def render("show.json", %{rule: rule}) do
    %{data: render_one(rule, __MODULE__, "rule.json")}
  end

  def render("rule.json", %{rule: rule}) do
    %{
      description: rule.description,
      bonus: rule.bonus,
      id: rule.id
    }
  end
end
