# typed: strict
# frozen_string_literal: true

module RailsAdmin
  module Config
    module Actions
      # Custom Rails Admin action specifically for ResponsePage model, to enqueue a ParseResponsePageJob for it
      class ParseResponsePage < RailsAdmin::Config::Actions::Base
        # Only visible on the ResponsePage model
        register_instance_option :visible? do
          authorized? && bindings[:object].instance_of?(ResponsePage)
        end

        # Requires a specific ResponsePage member, not the whole collection
        register_instance_option :member do
          true
        end

        # Icon for the button
        register_instance_option :link_icon do
          'icon-sync'
        end

        register_instance_option :controller do
          proc do
            T.bind(self, RailsAdmin::MainController)
            ParseResponsePageJob.perform_later(response_page: object)
            redirect_to show_path, flash: { success: 'ResponsePage parse enqueued' }
          end
        end

        RailsAdmin::Config::Actions.register(self)
      end
    end
  end
end
