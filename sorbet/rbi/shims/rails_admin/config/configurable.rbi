# typed: strict
# frozen_string_literal: true

module RailsAdmin
  module Config
    module Configurable
      mixes_in_class_methods ClassMethods

      module ClassMethods
        sig do
          params(
            option_name: T.any(Symbol, String),
            scope: T.untyped,
            default: T.proc.bind(RailsAdmin::Config::Actions::Base).returns(T.untyped),
          ).void
        end
        def register_instance_option(option_name, scope = self, &default); end
      end
    end
  end
end
