class Car
  attr_accessor :brand, :engine, :others

  def initialize(data={})
    @brand = data[:brand]
    data[:engine] ||= {}
    @engine = Engine.new(data[:engine])
    @others = data[:others]
  end

  def ==(other)
    brand == other.brand &&
    engine.horsepower == other.engine.horsepower &&
    others == other.others
  end
end

class Engine
  attr_reader :horsepower

  def initialize(data={})
    @horsepower = data[:horsepower]
  end
end
