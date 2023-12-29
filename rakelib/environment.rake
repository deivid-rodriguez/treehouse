# frozen_string_literal: true

desc 'Sets up the environment for the project'
task :environment do
  require 'bundler'
  Bundler.require
end
