# typed: strict
# frozen_string_literal: true

class CreateQueries < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    create_table :queries do |t|
      t.string :queryable_type, null: false
      t.string :queryable_id, null: false

      t.text :name, null: false
      t.text :description
      t.text :body, null: false

      t.timestamps
    end
    add_index :queries, %i[queryable_type queryable_id], unique: true
  end
end
