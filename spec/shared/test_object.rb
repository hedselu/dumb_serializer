# frozen_string_literal: true
shared_context 'test_object' do
  let(:object_data) { { brand: 'Honda', engine: { horsepower: 722 }, others: {} } }
  let(:object) { Car.new(object_data) }
end
