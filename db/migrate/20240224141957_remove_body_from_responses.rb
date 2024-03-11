# typed: strict
# frozen_string_literal: true

class RemoveBodyFromResponses < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    change_table :responses, bulk: true do |_t|
      remove_column :responses, :body, :text, null: false, default: ''
      remove_column :responses, :request_body, :text, null: false, default: ''
      remove_column :responses, :retrieved_at, :datetime, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
