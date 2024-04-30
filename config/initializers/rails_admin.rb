# typed: strict
# frozen_string_literal: true

Dir[Rails.root.join('lib/rails_admin/**/*.rb')].each { |file| require file }

RailsAdmin.config do |config|
  T.let(config, T.class_of(RailsAdmin::Config))

  config.asset_source = :vite

  config.parent_controller = '::ApplicationController'

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    T.bind(self, T.class_of(RailsAdmin::Config::Actions))

    dashboard

    index do
      T.unsafe(self).except do
        [
          Queryable::TYPES,
          Response::TYPES,
          ResponsePage,
          ResponsePageElement,
        ].flatten
      end
    end

    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show

    fetch_query
    parse_response_page
  end
end
