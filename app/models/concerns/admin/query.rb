# typed: false
# frozen_string_literal: true

module Admin
  module Query
    extend ActiveSupport::Concern
    extend Admin::Concern

    included do
      rails_admin do
        configure(:queryable) do
          pretty_value { value.class.name.demodulize }
        end

        exclude_fields :responses, :response_pages
      end
    end
  end
end
