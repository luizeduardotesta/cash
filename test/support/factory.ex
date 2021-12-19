defmodule Cash.Factory do
  use ExMachina.Ecto, repo: Cash.Repo

  use Cash.RuleFactory
  use Cash.PurchaseFactory
  use Cash.UserFactory
end
