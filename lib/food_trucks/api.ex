defmodule FoodTrucks.API do
  @moduledoc """
  API for searching for food trucks.
  """
  alias FoodTrucks.FoodTruck
  alias FoodTrucks.Repo

  import Ecto.Query

  @doc """
  Given a list of strings to search for, builds up a query to find all food
  trucks whose menu contains every search term.
  """
  @spec by_menu_item(list(binary())) :: Ecto.Query.t()
  def by_menu_item(search_terms) do
    base_query = from(ft in FoodTruck)

    search_terms
    |> Enum.reduce(base_query, &filter_by_menu_item/2)
    |> Repo.all()
  end

  @spec filter_by_menu_item(binary(), Ecto.Query.t()) :: Ecto.Query.t()
  defp filter_by_menu_item(search_term, query) do
    sanitized_search_term = sql_match_syntax(search_term)

    from ft in query, where: ilike(ft.food_items, ^sanitized_search_term)
  end

  @spec sql_match_syntax(binary()) :: binary()
  defp sql_match_syntax(value) do
    "%#{SqlSanitizer.sanitize(value)}%"
  end
end
