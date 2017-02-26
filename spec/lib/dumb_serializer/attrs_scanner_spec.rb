describe DumbSerializer::AttrsScanner do
  include_context 'test_object'

  let(:scanner) { DumbSerializer::AttrsScanner.new(object) }

  describe '#scan' do
    context 'when custom object' do
      let(:serialized_object) {{
        dd_class: 'Car',
        dd_vars: {
          brand: 'Honda',
          engine: {
            dd_class: 'Engine',
            dd_vars: { horsepower: 722 }},
          others: {} }}}

      it 'returns object attrbiutes as hash' do
        expect(scanner.scan).to eq(serialized_object)
      end
    end

    context 'when core type object' do
      let(:object) { 'CoreTypeObject' }

      it 'returns object attributes as hash' do
        expect{ scanner.scan }.to raise_error DumbSerializer::AttrsScanner::CoreTypeScanError
      end
    end
  end
end
