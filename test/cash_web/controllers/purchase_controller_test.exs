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

  describe "cashback_code/2" do
    setup %{conn: conn} do
      {:ok, conn: conn, purchase: insert(:purchase)}
    end

    test "returns a caskback's code when valid data", %{conn: conn, purchase: purchase} do
      code = :crypto.hash(:md5, "#{purchase.id} #{purchase.user.cpf}") |> Base.encode16()
      purchase = Cash.Repo.preload(purchase, :rule)

      conn = post(conn, "api/cashback_code/#{purchase.id}")

      assert subject = json_response(conn, 201)["data"]
      assert subject["value"] == Cash.Acquire.calc_cashback(purchase.price, purchase.rule.bonus)
      assert subject["code"] == code
    end
  end
end
