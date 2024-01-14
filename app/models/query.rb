# frozen_string_literal: true

# Represents a query of some external API
class Query < ApplicationRecord
  validates :type, :name, :body, presence: true

  def self.types
    [
      ::Queries::Overpass,
    ].freeze
  end
end
