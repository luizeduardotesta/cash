defmodule CashWeb.FallbackController do

  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.
  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use CashWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(CashWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, _}) do
    conn
    |> put_status(:bad_request)
    |> put_view(CashWeb.ErrorView)
    |> render(:"400")
  end
end
