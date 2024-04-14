# typed: strict
# frozen_string_literal: true

module RailsAdmin
  class MainController < RailsAdmin::ApplicationController
    sig { returns(String) }
    def show_path; end
  end
end
