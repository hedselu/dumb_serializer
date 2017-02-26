# frozen_string_literal: true
describe DumbSerializer::Configurable do
  describe '#config_db' do
    it 'allows set and get db config with options' do
      expect(Car.db_config).to include(TEST_DATABASE)
    end
  end

  describe '#config_db=' do
    let(:config_before) { { host: 'external_host', port: 1234 } }
    let(:config_after) { { host: '127.0.0.1', port: 27_017 } }

    before { Car.db_config = config_before }
    after { Car.db_config = config_after }

    it 'allows set and get db config with options' do
      expect(Car.db_config).to include(config_before)
    end
  end
end
