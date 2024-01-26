# typed: strict
# frozen_string_literal: true

class AddTypeToResponses < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    add_column :responses, :type, :string, null: false, default: 'Response'
  end
end
