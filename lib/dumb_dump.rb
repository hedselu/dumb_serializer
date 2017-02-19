Dir["#{Dir.pwd}/dumb_dump/*.rb"].each { |file| require_relative file }

# Module to supply class objects with mongodb storage.
module DumbDump
  attr_accessor :attrs_to_dump

  def self.included(klass)
    klass.extend Destroyable
    klass.extend Loadable
  end

  def setup_db(options)
    MongoConnector.setup(options)
  end

   def dump
     hashed = attrs_scanner.scan
     collection = MongoConnector.client[collection_name]
     collection.insert_one(hashed)
   end

  private

  def collection_name
    self.class.to_s
  end


  def attrs_scanner
    AttrsScanner.new(self)
  end
end
