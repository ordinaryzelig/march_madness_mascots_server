require 'bundler/setup'
require 'hanami/setup'
require_relative '../lib/march_madness_mascots_server'
require_relative '../apps/web/application'

Hanami::Container.configure do
  mount Web::Application, at: '/'
end
