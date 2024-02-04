# typed: strict
# frozen_string_literal: true

class AddTargetToGeocodes < ActiveRecord::Migration[7.1]
  extend T::Sig

  sig { void }
  def change
    add_reference :geocodes, :target, polymorphic: true, null: false # rubocop:disable Rails/NotNullColumn
  end
end
