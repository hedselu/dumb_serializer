current_path = File.expand_path(File.dirname(__FILE__))
Dir["#{current_path}/dumb_serializer/*.rb"].each { |file| require_relative file }

# Module to supply class objects with mongodb storage.
module DumbSerializer
  CORE_TYPES =
    [Bignum, Fixnum, Integer, String, TrueClass, FalseClass, Array, Hash, NilClass].freeze

  def self.included(klass)
    klass.extend Destroyable
    klass.extend Loadable
    klass.extend Configurable
    klass.include Serializable
  end
end
