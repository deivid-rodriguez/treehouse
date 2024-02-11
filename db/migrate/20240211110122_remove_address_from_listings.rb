# typed: strict
# frozen_string_literal: true

class RemoveAddressFromListings < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    remove_column :listings, :address, :text
  end
end
