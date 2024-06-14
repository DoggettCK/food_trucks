defmodule FoodTrucksWeb.FoodTrucksController do
  use FoodTrucksWeb, :controller

  alias FoodTrucks.API

  action_fallback FoodTrucksWeb.FallbackController

  def search(conn, %{"q" => search_terms}) do
    trucks = API.by_menu_item(search_terms)

    render(conn, :show, trucks: trucks)
  end
end
