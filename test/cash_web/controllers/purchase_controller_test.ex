defmodule CashWeb.PurchaseControllerTest do
  use CashWeb.ConnCase

  import Cash.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create/2" do
    test "return a rule when valid data", %{conn: conn} do
      params = params_for(:purchase)

      conn = post(conn, Routes.purchase_path(conn, :create), params)

      assert subject = json_response(conn, 201)["data"]
      assert subject["price"] == params.price
      assert subject["purchase_code"] == params.purchase_code
      assert subject["user_cpf"] == params.user_cpf
      assert subject["id"] != nil
    end

    test "return a error when invalid data", %{conn: conn} do
      params = params_for(:purchase, %{user_cpf: ""})

      conn = post(conn, Routes.purchase_path(conn, :create), params)

      assert %{"user_cpf" => ["can't be blank"]} = json_response(conn, 422)["errors"]
    end
  end
