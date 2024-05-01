# typed: false
# frozen_string_literal: true

module Admin
  module Parse
    extend ActiveSupport::Concern
    extend Admin::Concern

    included do
      rails_admin do
        %i[
          parseable
          response_page_element
          response_page
          response
        ].each do |field_name|
          configure(field_name) { eager_load? true }
        end
      end
    end
  end
end
