# typed: strict
# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    create_table :images do |t|
      t.references :listing, null: false, foreign_key: true
      t.text :url, null: false
      t.integer :index, null: false

      t.timestamps
    end
  end
end
