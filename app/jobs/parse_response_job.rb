# typed: strict
# frozen_string_literal: true

# Parses a specific response from an API
class ParseResponseJob < ApplicationJob
  extend T::Generic
  extend T::Sig

  queue_as :default

  sig { params(response: Response[T.untyped, T.untyped]).void }
  def perform(response:)
    Rails.logger.info { "Fetching response: #{response.inspect}" }
    Rails.logger.info { "Respondable: #{response.try(:respondable)&.inspect}" }

    entities = response.parse!
    Rails.logger.info { "Got entities: #{entities.to_a.inspect}" }
  end
end
