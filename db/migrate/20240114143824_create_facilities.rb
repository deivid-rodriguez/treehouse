# frozen_string_literal: true

class CreateFacilities < ActiveRecord::Migration[7.1]
  def change
    create_table :facilities do |t|
      t.string :type
      t.text :name
      t.text :address
      t.text :external_id, null: false

      t.timestamps
    end
    add_index :facilities, :external_id, unique: true
  end
end
