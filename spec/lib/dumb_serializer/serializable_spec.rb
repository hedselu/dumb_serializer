describe DumbSerializer::Serializable do
  include_context 'test_object'

  describe '#serialize' do
    before { object.serialize }
    it 'dumps object to mongodb' do
      expect(Car.all.length).to eq 1
    end
  end
end
