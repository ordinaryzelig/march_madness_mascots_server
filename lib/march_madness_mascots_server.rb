require 'hanami/model'
require 'hanami/mailer'
Dir["#{ __dir__ }/march_madness_mascots_server/**/*.rb"].each { |file| require_relative file }
require_relative './ext/pg_array'

Hanami::Model.configure do
  ##
  # Database adapter
  #
  # Available options:
  #
  #  * File System adapter
  #    adapter type: :file_system, uri: 'file:///db/bookshelf_development'
  #
  #  * Memory adapter
  #    adapter type: :memory, uri: 'memory://localhost/march_madness_mascots_server_development'
  #
  #  * SQL adapter
  #    adapter type: :sql, uri: 'sqlite://db/march_madness_mascots_server_development.sqlite3'
  #    adapter type: :sql, uri: 'postgres://localhost/march_madness_mascots_server_development'
  #    adapter type: :sql, uri: 'mysql://localhost/march_madness_mascots_server_development'
  #
  adapter type: :sql, uri: ENV['DATABASE_URL']

  ##
  # Database mapping
  #
  # Intended for specifying application wide mappings.
  #
  mapping do
    collection :entries do
      entity Entry
      repository EntryRepository
      attribute :name, String
      attribute :mascots, PGArray
    end
  end
end.load!

Hanami::Mailer.configure do
  root "#{ __dir__ }/march_madness_mascots_server/mailers"

  # See http://hanamirb.org/guides/mailers/delivery
  delivery do
    development :test
    test        :test
    # production :smtp, address: ENV['SMTP_PORT'], port: 1025
  end
end.load!
