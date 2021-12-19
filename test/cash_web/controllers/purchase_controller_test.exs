defmodule CashWeb.PurchaseControllerTest do
  use CashWeb.ConnCase

  import Cash.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create/2" do
    test "return a purchase when valid data", %{conn: conn} do
      user = insert(:user)
      params = params_with_assocs(:purchase, %{user_id: user.id})

      conn = post(conn, Routes.purchase_path(conn, :create), params)

      assert subject = json_response(conn, 201)["data"]
      assert subject["price"] == params.price
      assert subject["purchase_code"] == params.purchase_code
      assert subject["user_cpf"] == user.cpf
      assert subject["id"] != nil
    end

    test "return a error when invalid data", %{conn: conn} do
      params = params_for(:purchase, %{price: ""})

      conn = post(conn, Routes.purchase_path(conn, :create), params)

      assert %{"price" => ["can't be blank"]} = json_response(conn, 422)["errors"]
    end
  end

  describe "index/2" do
    test "list a purchase when valid data", %{conn: conn} do
      purchase = insert(:purchase)

      conn = get(conn, Routes.purchase_path(conn, :index))

      assert [subject] = json_response(conn, 200)["data"]
      assert subject["price"] == purchase.price
      assert subject["purchase_code"] == purchase.purchase_code
      assert subject["user_cpf"] == purchase.user.cpf
      assert subject["id"] == purchase.id
    end
  end
end
