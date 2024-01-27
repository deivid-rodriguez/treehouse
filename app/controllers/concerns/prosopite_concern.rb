# typed: strict
# frozen_string_literal: true

# Implements n+1 query detection in development
module ProsopiteConcern
  extend ActiveSupport::Concern
  extend T::Sig

  T.bind(self, T.class_of(ApplicationController))

  unless Rails.env.production?
    around_action :n_plus_one_detection

    sig { params(block: T.proc.void).void }
    def n_plus_one_query_detection(&block)
      Prosopite.scan
      block.call
    ensure
      Prosopite.finish
    end
  end
end
