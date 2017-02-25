require 'database_cleaner'
require_relative '../lib/dumb_serializer'
require_relative 'support/test_classes'

RSpec.configure do |config|
  # Silence logging
  Mongo::Logger.logger.level = ::Logger::FATAL

  config.before(:suite) do
    client = Mongo::Client.new('mongodb://127.0.0.1:27017/dumb_serializer_test')
    DatabaseCleaner[:mongo].strategy = :truncation
    DatabaseCleaner[:mongo].db = client.database
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
