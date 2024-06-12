# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FoodTrucks.Repo.insert!(%FoodTrucks.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
defmodule Conversions do
  def convert_boolean("0"), do: false
  def convert_boolean("1"), do: true

  def convert_date(""), do: nil
  def convert_date(str) when is_binary(str), do: DateTimeParser.parse!(str)

  def convert_float("0"), do: 0.0
  def convert_float(str) when is_binary(str), do: String.to_float(str)
end

"priv/repo/Mobile_Food_Facility_Permit.csv"
|> File.stream!()
|> CSV.decode(headers: true)
|> Enum.each(fn {:ok, line} ->
  %{
    address: get_in(line, ["Address"]),
    applicant: get_in(line, ["Applicant"]),
    approved_date: line |> get_in(["Approved"]) |> Conversions.convert_date(),
    expiration_date: line |> get_in(["ExpirationDate"]) |> Conversions.convert_date(),
    facility_type: get_in(line, ["FacilityType"]),
    food_items: get_in(line, ["FoodItems"]),
    latitude: line |> get_in(["Latitude"]) |> Conversions.convert_float(),
    location_description: get_in(line, ["LocationDescription"]),
    location_id: line |> get_in(["locationid"]) |> String.to_integer(),
    longitude: line |> get_in(["Longitude"]) |> Conversions.convert_float(),
    permit: get_in(line, ["permit"]),
    prior_permit: line |> get_in(["PriorPermit"]) |> Conversions.convert_boolean(),
    received: line |> get_in(["Received"]) |> Conversions.convert_date(),
    schedule: get_in(line, ["Schedule"]),
    status: get_in(line, ["Status"]),
    zip_codes: get_in(line, ["Zip Codes"])
  }
  |> then(&FoodTrucks.FoodTruck.changeset(%FoodTrucks.FoodTruck{}, &1))
  |> FoodTrucks.Repo.insert!()
end)
