defmodule FoodTrucks.APITest do
  use FoodTrucks.DataCase

  alias FoodTrucks.API
  alias FoodTrucks.FoodTruck

  describe "by_menu_item/1" do
    test "returns all food trucks if no search terms specified" do
      search_terms = []
      expected_count = Repo.aggregate(FoodTruck, :count, :id)

      food_trucks = API.by_menu_item(search_terms)

      assert ^expected_count = length(food_trucks)
    end

    test "returns all food trucks matching a single search term" do
      search_terms = ["meat"]
      expected_count = 23

      food_trucks = API.by_menu_item(search_terms)

      assert Enum.all?(food_trucks, fn food_truck ->
               Enum.all?(search_terms, fn search_term ->
                 Regex.match?(~r/#{search_term}/i, food_truck.food_items)
               end)
             end)

      assert ^expected_count = length(food_trucks)
    end

    test "returns all food trucks matching multiple search terms" do
      search_terms = ["meat", "bread", "seafood"]
      expected_count = 2

      food_trucks = API.by_menu_item(search_terms)

      assert Enum.all?(food_trucks, fn food_truck ->
               Enum.all?(search_terms, fn search_term ->
                 Regex.match?(~r/#{search_term}/i, food_truck.food_items)
               end)
             end)

      assert ^expected_count = length(food_trucks)
    end
  end
end
