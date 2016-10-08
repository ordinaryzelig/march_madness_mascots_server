require 'hanami/model/coercer'
require 'sequel'
require 'sequel/extensions/pg_array'
Sequel.extension :pg_array

class PGArray < Hanami::Model::Coercer
  def self.dump(value)
    ::Sequel.pg_array(value, :varchar)
  end

  def self.load(value)
    ::Kernel.Array(value) unless value.nil?
  end
end
