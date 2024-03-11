# typed: strict
# frozen_string_literal: true

# Fetches the next page of a Response from the corresponding API
class FetchNextPageJob < ApplicationJob
  extend T::Sig

  queue_as :default

  sig { params(page: ResponsePage).void }
  def perform(page:)
    log(page)

    next_page = fetch_page_after(page)
    next_page&.save!

    return unless next_page&.next_page?

    Rails.logger.info { 'Enqueueing another job to fetch the page after' }
    FetchNextPageJob.perform_later(page: next_page)
  end

  private

  sig { params(page: ResponsePage).void }
  def log(page)
    Rails.logger.info { "Fetching next page: #{page.inspect}" }
    Rails.logger.info { "Query: #{page.response&.query.inspect}, #{page.response&.query.try(:queryable)&.inspect}" }
  end

  sig { params(page: ResponsePage).returns(T.nilable(ResponsePage)) }
  def fetch_page_after(page)
    next_page = page.response&.fetch!(page_after: page)
    Rails.logger.info { "Got response: #{next_page.inspect}" }

    next_page
  end
end
