# typed: strict
# frozen_string_literal: true

class CreateResponsePageElements < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    create_table :response_page_elements do |t|
      t.references :response_page, null: false, foreign_key: true
      t.integer :index, null: false
      t.string :external_id, null: true

      t.timestamps
    end

    # Each of the elements from a response page should be parsed only once
    add_index :response_page_elements, %i[response_page_id index], unique: true
  end
end
