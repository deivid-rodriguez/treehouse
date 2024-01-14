# frozen_string_literal: true

# Represents a query of some external API
class Query < ApplicationRecord
  delegated_type :queryable, types: %w[Queries::Overpass]
  accepts_nested_attributes_for :queryable

  validates :queryable, :name, :body, presence: true
end
