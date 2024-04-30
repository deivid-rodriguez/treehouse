# typed: false
# frozen_string_literal: true

module Admin
  module Image
    extend ActiveSupport::Concern
    extend Admin::Concern

    included do
      rails_admin do
        configure :url do
          label { name.to_s.upcase }
          formatted_value { bindings[:view].link_to value, value, target: '_blank', rel: 'noopener' }
        end

        list do
          include_fields :id, :listing, :index, :url, :created_at

          configure(:id) { column_width 70 }
          configure(:listing) { column_width 120 }
          configure(:index) { column_width 40 }
          configure(:created_at) { column_width 180 }
        end

        show do
          include_fields :id, :listing, :index, :url

          field :preview do
            formatted_value do
              url = bindings[:object].url
              bindings[:view].link_to url, target: '_blank', rel: 'noopener' do
                bindings[:view].image_tag url, style: 'width: 600px; max-width: 100%;'
              end
            end
          end
        end
      end
    end
  end
end
