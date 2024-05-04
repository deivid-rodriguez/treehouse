# typed: false
# frozen_string_literal: true

module Admin
  module Listing
    extend ActiveSupport::Concern
    extend Admin::Concern

    included do
      rails_admin do
        %i[
          address
          geocodes
          images
          parses
          price
          responses
          response_pages
          response_page_elements
        ].each do |field_name|
          configure(field_name) { eager_load? true }
        end

        list do
          include_fields :id, :external_id, :address, :price

          configure(:bedroom_count) { label 'Beds' }
          configure(:bathroom_count) { label 'Bath' }
          configure(:carpark_count) { label 'Cars' }

          include_all_fields

          exclude_fields :description
        end

        show do
          include_fields :external_id, :address, :price, :bedroom_count, :bathroom_count, :carpark_count,
            :description, :images

          include_all_fields

          configure :description do
            formatted_value { value }
          end

          configure :images do
            pretty_value do
              view = bindings[:view]

              image_tags = bindings[:object].images.sort_by(&:index).map do |image|
                view.link_to view.rails_admin.show_path(:image, image) do
                  view.image_tag image.url, style: 'width: 200px; max-width: 50%;'
                end
              end

              image_tags.join.html_safe.presence || '-' # rubocop:disable Rails/OutputSafety
            end
          end
        end
      end
    end
  end
end
