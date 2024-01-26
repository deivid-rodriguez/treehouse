# typed: strict
# frozen_string_literal: true

class CreateOverpassQueries < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    create_table :overpass_queries do |t|
      t.string :facility_type, null: false

      t.timestamps
    end
  end
end
