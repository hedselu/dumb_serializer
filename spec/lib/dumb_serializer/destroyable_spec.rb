describe DumbSerializer::Destroyable do
  include_context 'test_object'


  describe '.remove' do
    let!(:id) { object.serialize.inserted_id.to_s }

    it 'removes object with given id from database' do
      expect{ Car.remove(id) }.to change{ Car.all.length }.from(1).to(0)
    end
  end

  describe '.drop' do
    before { object.serialize }

    it 'drops collection' do
      expect{ Car.drop }.to change{ Car.all.length }.from(1).to(0)
    end
  end
end
