# typed: false
# frozen_string_literal: true

module Admin
  module Response
    extend ActiveSupport::Concern
    extend Admin::Concern

    included do
      rails_admin do
        %i[
          elements
          pages
          parses
          query
        ].each do |field_name|
          configure(field_name) { eager_load? true }
        end
      end
    end
  end
end
