module DumbSerializer
  module Destroyable
    def remove(id)
      MongoConnector.client[collection_name].find(_id: BSON::ObjectId(id)).delete_one
    end

    def drop
      MongoConnector.client[collection_name].drop
    end

    private

    def collection_name
      class_name.downcase
    end

    def class_name
      to_s
    end
  end
end
