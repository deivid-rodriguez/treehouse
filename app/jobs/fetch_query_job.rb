# typed: strict
# frozen_string_literal: true

# Fetches a specific query from the corresponding API
class FetchQueryJob < ApplicationJob
  extend T::Sig

  queue_as :default

  sig { params(query: Query).void }
  def perform(query:)
    log(query)

    response = query.build_response
    return if response.nil?

    first_page = response.fetch!
    Rails.logger.info { "Got response: #{first_page.inspect}" }

    first_page&.save!
    return unless first_page&.next_page?

    Rails.logger.info { 'Enqueueing another job to fetch the page after' }
    FetchNextPageJob.perform_later(page: first_page)
  end

  private

  sig { params(query: Query).void }
  def log(query)
    Rails.logger.info { "Fetching query: #{query.inspect}" }
    Rails.logger.info { "Queryable: #{query.try(:queryable)&.inspect}" }
  end
end
