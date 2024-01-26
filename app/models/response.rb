# frozen_string_literal: true

# Represents the response fetched for a query at some point in time
class Response < ApplicationRecord
  attribute :retrieved_at, default: -> { Time.zone.now }

  # Default value for request_body should be the query.body at the time of the query
  before_validation { self.request_body ||= query&.body }

  belongs_to :query, inverse_of: :responses

  validates :body, :request_body, :retrieved_at, presence: true
end
