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
  end

  # TBH it's ugly with this included_class.mongo_client etc. Looks too complex
  # and dependent on each other. At this time couldn't find better way.
  def dump
    hashed = attrs_scanner.scan
    collection = MongoConnector.client[collection_name]
    collection.insert_one(hashed)
  end

  private

  def collection_name
    included_class.to_s
  end

  def included_class
    self.class
  end

  def attrs_scanner
    AttrsScanner.new(self)
  end
end
