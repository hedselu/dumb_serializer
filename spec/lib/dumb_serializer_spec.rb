require 'spec_helper'

describe DumbSerializer do
  let(:object) { Car.new }

  it { expect(object).to respond_to(:serialize) }
  it { expect(Car).to respond_to(:find) }
  it { expect(Car).to respond_to(:all) }
  it { expect(Car).to respond_to(:remove) }
  it { expect(Car).to respond_to(:drop) }
  it { expect(Car).to respond_to(:db_config) }
  it { expect(Car).to respond_to(:db_config=) }
end
