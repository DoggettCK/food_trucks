defmodule FoodTrucksWeb.FoodTrucksJSON do
  alias FoodTrucks.FoodTruck

  @doc """
  Renders a list of trucks.
  """
  def index(%{trucks: trucks}) do
    %{data: for(truck <- trucks, do: data(truck))}
  end

  @doc """
  Renders a single truck.
  """
  def show(%{trucks: trucks}) when is_list(trucks) do
    %{data: for(truck <- trucks, do: data(truck))}
  end

  defp data(%FoodTruck{} = truck) do
    Map.take(truck, ~w(
      address
      applicant
      approved_date
      expiration_date
      facility_type
      food_items
      latitude
      longitude
      location_description
      permit
      schedule
      status
    )a)
  end
end
