defmodule FoodTrucksWeb.FoodTrucksController do
  @moduledoc false
  use FoodTrucksWeb, :controller

  alias FoodTrucks.API

  action_fallback FoodTrucksWeb.FallbackController

  @doc """
  When called via /food_trucks/by_item?q[]=meat&q[]=bread&q[]=seafood, it will
  query the FoodTrucks API using the list of terms provided in the `q`
  parameter. If `q` is not provided, it will return every food truck in the DB.
  In a real system, or with more time, this would be paginated.
  """
  def search(conn, params) do
    search_terms = Map.get(params, "q", [])

    trucks = API.by_menu_item(search_terms)

    render(conn, :show, trucks: trucks)
  end
end
