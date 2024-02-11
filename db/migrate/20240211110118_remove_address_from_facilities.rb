# typed: strict
# frozen_string_literal: true

class RemoveAddressFromFacilities < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    remove_column :facilities, :address, :text
  end
end
