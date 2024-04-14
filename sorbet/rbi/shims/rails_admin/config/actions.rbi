# typed: strict
# frozen_string_literal: true

module RailsAdmin
  module Config
    module Actions
      class << self
        sig { void }
        def fetch_query; end

        sig { void }
        def parse_response_page; end
      end
    end
  end
end
