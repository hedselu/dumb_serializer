# frozen_string_literal: true
describe DumbSerializer::MongoConnector do
  let(:mongo_connector) { DumbSerializer::MongoConnector }
  let(:default_config) { DumbSerializer::MongoConnector::DEFAULT_OPTIONS }
  let(:custom_database) { { database: 'db_name' } }

  after { mongo_connector.db_config = default_config.merge(TEST_DATABASE) }

  describe '.client' do
    let(:client_options) { mongo_connector.client.options }
    let(:symbolized_client_options) { symbolize_keys(client_options) }

    context 'when config was set' do
      before { mongo_connector.db_config = custom_database }

      it 'returns client with custom config' do
        expect(symbolized_client_options).to include(custom_database)
      end
    end

    context 'when config was not set' do
      it 'returns client with default config' do
        expect(symbolized_client_options).to include(TEST_DATABASE)
      end
    end
  end

  describe '.db_config' do
    let(:symbolized_client_config) { symbolize_keys(mongo_connector.db_config) }

    it 'returns actual database config' do
      expect(symbolized_client_config).to include(default_config)
    end
  end

  describe '.db_config=' do
    let(:resulted_config) { default_config.merge(custom_database) }
    before { mongo_connector.db_config = custom_database }

    it 'sets missing params to defaults' do
      expect(mongo_connector.db_config).to eq(resulted_config)
    end
  end
end

def symbolize_keys(hash)
  hash.each_with_object({}).each do |(k, v), cpy_hash|
    sym_k = k.to_sym
    cpy_hash[sym_k] = v
  end
end
