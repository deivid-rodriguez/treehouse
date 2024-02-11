# typed: strict
# frozen_string_literal: true

class RemoveAddressFromGeocodes < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    remove_column :geocodes, :address, :text
  end
end
