# frozen_string_literal: true
module DumbSerializer
  module Configurable
    def db_config=(config)
      MongoConnector.db_config = config
    end

    def db_config
      MongoConnector.db_config
    end
  end
end
