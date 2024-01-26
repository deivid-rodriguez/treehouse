# typed: strict
# frozen_string_literal: true

class CreateGeocodes < ActiveRecord::Migration[7.1]
  def change
    create_table :geocodes do |t|
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.integer :certainty
      t.text :address, null: false

      t.timestamps
    end
  end
end
