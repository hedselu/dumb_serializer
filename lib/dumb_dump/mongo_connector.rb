# frozen_string_literal: true
require 'mongo'

module DumbDump
  class MongoConnector
    DEFAULT_OPTIONS = {
      db_name: 'dumbdump',
      host: '127.0.0.1',
      port: '27017'
    }.freeze

    class << self
      def client
        @client || config
      end

      def config(options={})
        options = DEFAULT_OPTIONS.merge(options)
        @client = Mongo::Client.new(connection_url(options))
      end

      private

      def connection_url(options)
        'mongodb://' + options[:host] + ':' + options[:port] + '/' + options[:db_name]
      end
    end
  end
end
