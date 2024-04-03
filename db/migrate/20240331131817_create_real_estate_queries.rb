# typed: strict
# frozen_string_literal: true

class CreateRealEstateQueries < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    create_table :real_estate_queries do |t| # rubocop:disable Style/SymbolProc
      t.timestamps
    end
  end
end
