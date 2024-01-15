# frozen_string_literal: true

# Represents the response fetched for a query at some point in time
class Response < ApplicationRecord
  belongs_to :query, inverse_of: :responses

  validates :body, :query, :request_body, :retrieved_at, presence: true
end
