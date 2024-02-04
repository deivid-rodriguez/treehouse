# typed: strict
# frozen_string_literal: true

class CreateDomainQueries < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    create_table :domain_queries do |t| # rubocop:disable Style/SymbolProc
      t.timestamps
    end
  end
end
