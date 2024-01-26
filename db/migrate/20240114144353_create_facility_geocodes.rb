# typed: strict
# frozen_string_literal: true

class CreateFacilityGeocodes < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    create_table :facility_geocodes do |t|
      t.references :facility, null: false, foreign_key: true
      t.references :geocode, null: false, foreign_key: true

      t.timestamps
    end
  end
end
