defmodule FoodTrucksWeb.FoodTrucksControllerTest do
  use FoodTrucksWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "search" do
    test "lists all trucks", %{conn: conn} do
      expected_length = 629

      conn = get(conn, ~p"/api/v1/food_trucks/by_item")

      food_trucks = json_response(conn, 200)["data"]

      assert is_list(food_trucks)
      assert ^expected_length = length(food_trucks)
    end

    test "lists all trucks offering meat", %{conn: conn} do
      expected_length = 23

      conn = get(conn, ~p"/api/v1/food_trucks/by_item?q[]=meat")

      food_trucks = json_response(conn, 200)["data"]

      assert is_list(food_trucks)
      assert ^expected_length = length(food_trucks)
    end

    test "lists all trucks offering meat and bread", %{conn: conn} do
      expected_length = 5

      conn = get(conn, ~p"/api/v1/food_trucks/by_item?q[]=meat&q[]=bread")

      food_trucks = json_response(conn, 200)["data"]

      assert is_list(food_trucks)
      assert ^expected_length = length(food_trucks)
    end

    test "lists all trucks offering meat, bread, and seafood", %{conn: conn} do
      expected_length = 2

      conn = get(conn, ~p"/api/v1/food_trucks/by_item?q[]=meat&q[]=bread&q[]=seafood")

      food_trucks = json_response(conn, 200)["data"]

      assert is_list(food_trucks)
      assert ^expected_length = length(food_trucks)
    end
  end
end
