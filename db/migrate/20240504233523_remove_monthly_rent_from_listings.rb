# typed: strict
# frozen_string_literal: true

class RemoveMonthlyRentFromListings < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    remove_column :listings, :monthly_rent, :integer
  end
end
