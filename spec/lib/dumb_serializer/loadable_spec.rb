describe DumbSerializer::Loadable do
  include_context 'test_object'

  describe '.find' do
    let(:id) { object.serialize.inserted_id.to_s }
    let(:object_found) { Car.find(id) }

    it 'returns Car object' do
      expect(object_found.class).to eq(Car)
    end

    it 'returns saved object' do
      expect(object_found).to eq(object)
    end
  end

  describe '.all' do
    before { object.serialize }

    it 'returns array' do
      expect(Car.all).to be_a(Array)
    end

    it 'includes saved objects of certain class' do
      expect(Car.all).to include(object)
    end
  end
end
