defmodule FoodTrucks.Repo.Migrations.CreateFoodTrucks do
  use Ecto.Migration

  def up do
    create table(:food_trucks) do
      add :address, :string, null: false
      add :applicant, :string, null: false
      add :approved_date, :naive_datetime
      add :expiration_date, :naive_datetime
      add :facility_type, :string
      add :food_items, :string, size: 1000
      add :latitude, :float, null: false
      add :location_description, :string
      add :location_id, :integer, null: false
      add :longitude, :float, null: false
      add :permit, :string, null: false
      add :prior_permit, :boolean, default: false, null: false
      add :received, :date, null: false
      add :schedule, :string
      add :status, :string
      add :zip_codes, :string

      timestamps(type: :utc_datetime)
    end

    execute "CREATE EXTENSION IF NOT EXISTS pg_trgm;"

    execute """
      CREATE INDEX food_trucks_food_items_gin_trgm_idx
        ON food_trucks
        USING gin (food_items gin_trgm_ops);
    """
  end

  def down do
    drop table(:food_trucks)
  end
end
