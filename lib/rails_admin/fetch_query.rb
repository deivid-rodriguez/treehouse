# typed: strict
# frozen_string_literal: true

module RailsAdmin
  module Config
    module Actions
      # Custom Rails Admin action specifically for Query model, to enqueue a FetchQueryJob for it
      class FetchQuery < RailsAdmin::Config::Actions::Base
        # Only visible on the Query model
        register_instance_option :visible? do
          authorized? && bindings[:object].instance_of?(Query)
        end

        # Requires a specific Query member, not the whole collection
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
            FetchQueryJob.perform_later(query: object)
            redirect_to show_path, flash: { success: 'Query fetch enqueued' }
          end
        end
      end
    end
  end
end
