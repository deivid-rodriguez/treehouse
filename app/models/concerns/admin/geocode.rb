# typed: false
# frozen_string_literal: true

module Admin
  module Geocode
    extend ActiveSupport::Concern
    extend Admin::Concern

    included do
      rails_admin do
        %i[
          address
          target
        ].each do |field_name|
          configure(field_name) { eager_load? true }
        end

        show do
          configure :map do
            formatted_value do
              latitude = bindings[:object].latitude
              longitude = bindings[:object].longitude

              bindings[:view].static_map(latitude:, longitude:) if latitude.present? && longitude.present?
            end
          end
        end
      end
    end
  end
end
