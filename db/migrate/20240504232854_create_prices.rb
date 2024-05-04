# typed: strict
# frozen_string_literal: true

class CreatePrices < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    create_table :prices do |t|
      t.references :listing, null: false, foreign_key: true, index: { unique: true }
      t.string :type, null: false
      t.decimal :value
      t.decimal :min
      t.decimal :max
      t.string :display

      t.timestamps
    end
  end
end
