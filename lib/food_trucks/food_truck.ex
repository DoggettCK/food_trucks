defmodule FoodTrucks.FoodTruck do
  @moduledoc """
  Ecto schema for food trucks.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "food_trucks" do
    field :address, :string
    field :applicant, :string
    field :approved_date, :naive_datetime
    field :expiration_date, :naive_datetime
    field :facility_type, :string
    field :food_items, :string
    field :latitude, :float
    field :location_description, :string
    field :location_id, :integer
    field :longitude, :float
    field :permit, :string
    field :prior_permit, :boolean, default: false
    field :received, :date
    field :schedule, :string
    field :status, :string
    field :zip_codes, :string

    timestamps(type: :utc_datetime)
  end

  @fields ~w(
    address
    applicant
    approved_date
    expiration_date
    facility_type
    food_items
    latitude
    location_id
    location_description
    longitude
    permit
    prior_permit
    received
    schedule
    status
    zip_codes
  )a

  @required_fields ~w(
    address
    applicant
    latitude
    location_id
    longitude
    permit
    prior_permit
    received
    schedule
    status
  )a

  @doc false
  def changeset(food_truck, attrs) do
    food_truck
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
  end
end
