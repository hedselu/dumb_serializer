module DumbSerializer
  module Serializable
    def serialize
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
end
