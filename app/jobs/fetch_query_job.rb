# frozen_string_literal: true

# Fetches a specific query from the corresponding API
class FetchQueryJob < ApplicationJob
  queue_as :default

  def perform(query:)
    Rails.logger.info { "Fetching query: #{query.inspect}" }
    Rails.logger.info { "Queryable: #{query.queryable&.inspect}" }

    response = fetch_response(query:)
    append_response(query:, response:)
  end

  private

  def fetch_response(query:)
    client.query(body: query.body).tap do |response|
      Rails.logger.info { "Got response: #{response.slice(0, 200)}" }
    end
  rescue StandardError => e
    Rails.logger.error { "Failed to fetch response: #{e.inspect}" }
    raise
  end

  def append_response(query:, response:)
    query.responses.create!(body: response, request_body: query.body, retrieved_at: Time.zone.now)
  end

  def client
    @client ||= APIClient::Overpass.new
  end
end
