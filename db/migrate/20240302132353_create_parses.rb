# typed: strict
# frozen_string_literal: true

class CreateParses < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    create_table :parses do |t|
      t.references :parseable, polymorphic: true, null: false
      t.references :response_page_element, null: false, foreign_key: true

      t.timestamps
    end
  end
end
