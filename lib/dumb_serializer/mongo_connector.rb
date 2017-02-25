require 'mongo'

module DumbSerializer
  module MongoConnector
    DEFAULT_OPTIONS = {
      database: 'dumb_serializer',
      host: '127.0.0.1',
      port: '27017'
    }

    class << self
      attr_reader :db_config
      attr_writer :client

      def client
        @client || client_setup
      end

      def db_config=(options)
        @db_config ||= DEFAULT_OPTIONS
        @db_config.merge!(options)
        @client.close if @client
        @client = Mongo::Client.new(connection_url(@db_config))
      end

      private

      def client_setup
        @client = Mongo::Client.new(connection_url(DEFAULT_OPTIONS))
      end

      def connection_url(options)
        'mongodb://' + options[:host] + ':' + options[:port].to_s + '/' + options[:database]
      end
    end
  end
end
