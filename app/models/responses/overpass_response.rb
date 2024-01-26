# typed: strict
# frozen_string_literal: true

module Responses
  # Represents a response from querying the Overpass API
  class OverpassResponse < Response
    extend T::Sig

    sig { override.returns(T::Array[T.untyped]) }
    def parse!
      raise NotImplementedError, 'TODO: Implement osm2geojson, but instead of GeoJSON files create PostGIS entities'
    end
  end
end
