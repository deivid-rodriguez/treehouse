# typed: strict
# frozen_string_literal: true

class CreateResponsePages < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    create_table :response_pages do |t|
      t.references :response, null: false, foreign_key: true
      t.integer :page_number, null: false
      t.string :external_page_id, null: false
      t.text :request_body, null: false
      t.text :body, null: false
      t.datetime :retrieved_at, null: false
      t.boolean :next_page, null: false, default: false

      t.timestamps
    end

    # Each page of a response has its own unique page number
    add_index :response_pages, %i[response_id page_number], unique: true
    add_index :response_pages, %i[response_id external_page_id]
  end
end
