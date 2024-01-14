# frozen_string_literal: true

class CreateQueries < ActiveRecord::Migration[7.1]
  def change
    create_table :queries do |t|
      t.string :type, null: false
      t.text :name, null: false
      t.text :description
      t.text :body, null: false

      t.timestamps
    end
    add_index :queries, :type
  end
end
