defmodule Cash.Repo do
  use Ecto.Repo,
    otp_app: :cash,
    adapter: Ecto.Adapters.Postgres
end
