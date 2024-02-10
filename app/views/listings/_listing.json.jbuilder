# frozen_string_literal: true

json.extract! listing, :id, :created_at, :updated_at
json.url listing_url(listing, format: :json)
