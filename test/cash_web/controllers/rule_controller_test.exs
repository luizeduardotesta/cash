defmodule CashWeb.RuleControllerTest do
  use CashWeb.ConnCase

  import Cash.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create/2" do
    test "return a rule when valid data", %{conn: conn} do
      params = params_for(:rule)

      conn = post(conn, Routes.rule_path(conn, :create), params)

      assert subject = json_response(conn, 201)["data"]
      assert subject["description"] == params.description
      assert subject["bonus"] == params.bonus
      assert subject["id"] != nil
    end
  end
end
