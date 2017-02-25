require 'spec_helper'

describe DumbSerializer do
  let(:object_data) {{ brand: 'Honda', engine: { horsepower: 722 }, others: {}}}
  let(:object) { Car.new(object_data) }

  before(:all) do
    Car.include(DumbSerializer)
    config = { database: 'dumb_serializer_test' }
    Car.db_config = config
  end

  describe '.find' do
    let(:id) { object.dump.inserted_id.to_s }
    let(:object_found) { Car.find(id) }
    it 'returns Car object' do
      expect(object_found.class).to eq(Car)
    end

    it 'returns saved object' do
      expect(object_found).to eq(object)
    end
  end

  describe '.all' do
    before { object.dump }
    it 'returns array' do
      expect(Car.all).to be_a(Array)
    end

    it 'includes saved objects of certain class' do
      expect(Car.all).to include(object)
    end
  end

  describe '#dump' do
    before { object.dump }
    it 'dumps object to mongodb' do
      expect(Car.all.length).to eq 1
    end
  end

  describe '#config_db' do
    it 'allows set and get db config with options' do
      expect(Car.db_config).to include(database: 'dumb_serializer_test')
    end
  end

  describe '#config_db=' do
    let(:config_before) {{ host: 'external_host', port: 1234 }}
    let(:config_after) {{ host: '127.0.0.1', port: 27017 }}

    before { Car.db_config = config_before }
    after { Car.db_config = config_after }

    it 'allows set and get db config with options' do
      expect(Car.db_config).to include(config_before)
    end
  end
end
