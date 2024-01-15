# frozen_string_literal: true

module Queries
  # Represents a query of the Overpass API
  class OverpassQuery < ApplicationRecord
    include Queryable

    validates :facility_type, presence: true
  end
end
