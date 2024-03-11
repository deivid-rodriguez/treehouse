# typed: strict
# frozen_string_literal: true

# Parses a specific response from an API
class ParseResponsePageJob < ApplicationJob
  extend T::Generic
  extend T::Sig

  queue_as :default

  sig { params(response_page: ResponsePage).void }
  def perform(response_page:)
    Rails.logger.info { "Parsing response page: #{response_page.inspect}" }
    Rails.logger.info { "Response: #{response_page.response.inspect}" }

    parses = response_page.parse!
    Rails.logger.info { "Parsed into: #{parses.count.inspect} entities" }

    parses.each do |parse|
      handle(parse)
    end
  end

  private

  sig { params(parse: Parse).void }
  def handle(parse)
    Parse.transaction do
      if parse.save
        Rails.logger.info { "Saved parse: #{parse.inspect}" }
      else
        Rails.logger.error { "Failed to save parse: #{parse.inspect}" }
        Rails.logger.error { "Errors: #{parse.errors.full_messages.inspect}" }
      end
    end
  end
end
