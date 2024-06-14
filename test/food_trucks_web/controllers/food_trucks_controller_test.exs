defmodule FoodTrucksWeb.FoodTrucksControllerTest do
  use FoodTrucksWeb.ConnCase

  import FoodTrucks.FoodTruckFixtures

  alias FoodTrucks.FoodTruck.Truck

  @create_attrs %{
    name: "some name",
    food_items: "some food_items"
  }
  @update_attrs %{
    name: "some updated name",
    food_items: "some updated food_items"
  }
  @invalid_attrs %{name: nil, food_items: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all trucks", %{conn: conn} do
      conn = get(conn, ~p"/api/trucks")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create truck" do
    test "renders truck when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/trucks", truck: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/trucks/#{id}")

      assert %{
               "id" => ^id,
               "food_items" => "some food_items",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/trucks", truck: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update truck" do
    setup [:create_truck]

    test "renders truck when data is valid", %{conn: conn, truck: %Truck{id: id} = truck} do
      conn = put(conn, ~p"/api/trucks/#{truck}", truck: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/trucks/#{id}")

      assert %{
               "id" => ^id,
               "food_items" => "some updated food_items",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, truck: truck} do
      conn = put(conn, ~p"/api/trucks/#{truck}", truck: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete truck" do
    setup [:create_truck]

    test "deletes chosen truck", %{conn: conn, truck: truck} do
      conn = delete(conn, ~p"/api/trucks/#{truck}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/trucks/#{truck}")
      end
    end
  end

  defp create_truck(_) do
    truck = truck_fixture()
    %{truck: truck}
  end
end
