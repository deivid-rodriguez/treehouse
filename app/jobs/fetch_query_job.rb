# typed: strict
# frozen_string_literal: true

# Fetches a specific query from the corresponding API
class FetchQueryJob < ApplicationJob
  queue_as :default

  def perform(query:)
    Rails.logger.info { "Fetching query: #{query.inspect}" }
    Rails.logger.info { "Queryable: #{query.try(:queryable)&.inspect}" }

    response = query.fetch!
    Rails.logger.info { "Got response: #{response.slice(0, 200)}" }

    query.responses.create!(body: response)
  end
end
