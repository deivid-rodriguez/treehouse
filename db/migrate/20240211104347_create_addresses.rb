# typed: strict
# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    create_table :addresses do |t|
      t = T.let(t, ActiveRecord::ConnectionAdapters::TableDefinition)

      t.references :addressable, polymorphic: true, null: false, index: true

      t.string :unit
      t.string :house
      t.string :street
      t.string :city
      t.string :state
      t.string :postcode

      t.timestamps
    end
  end
end
