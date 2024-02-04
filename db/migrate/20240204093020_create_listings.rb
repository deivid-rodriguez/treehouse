# typed: strict
# frozen_string_literal: true

class CreateListings < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    create_table :listings do |t|
      t.string :external_id, null: false
      t.text :address
      t.text :description
      t.float :bathroom_count
      t.float :bedroom_count
      t.integer :carpark_count
      t.float :building_area
      t.float :land_area
      t.text :property_type
      t.integer :monthly_rent
      t.boolean :is_rural, null: false, default: false
      t.boolean :is_new, null: false, default: false
      t.text :slug
      t.datetime :listed_at
      t.datetime :available_at
      t.datetime :last_seen_at, null: false

      t.timestamps
    end
  end
end
