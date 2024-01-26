# typed: strict
# frozen_string_literal: true

class CreateResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :responses do |t|
      t.references :query, null: false, foreign_key: true
      t.text :request_body, null: false
      t.text :body, null: false
      t.datetime :retrieved_at, null: false

      t.timestamps
    end
  end
end
