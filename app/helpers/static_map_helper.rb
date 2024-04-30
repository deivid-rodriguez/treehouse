# typed: strict
# frozen_string_literal: true

require 'uri'

# Adds a view helper to generate a static map image using the Google Static Maps API
module StaticMapHelper
  extend T::Helpers
  extend T::Sig

  requires_ancestor { ActionView::Base }

  BASE_URL = 'https://maps.googleapis.com/maps/api/staticmap'

  sig { params(latitude: T.any(String, Numeric), longitude: T.any(String, Numeric)).returns(String) }
  def static_map(latitude:, longitude:)
    return '[no google maps API key]' if ENV['GOOGLE_MAPS_API_KEY'].blank?

    params = {
      markers: ['color:red', [latitude, longitude].join(',')].join('|'),
      zoom: 14,
      size: '640x480',
      key: ENV.fetch('GOOGLE_MAPS_API_KEY'),
    }

    url = T.let(Kernel.URI(BASE_URL), URI::HTTPS)
    url.query = params.to_query

    image_tag url.to_s, alt: 'Google Maps'
  end
end
