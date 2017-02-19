require_relative 'dumb_dump'
require 'benchmark'

Mongo::Logger.logger.level = ::Logger::FATAL

class Engine
  def initialize
    @horse_power = 722
    @type = 'S'
    @manufacturer = 'Honda'
    @kilometers = 123123123
  end
end

class Car
  include DumbDump

  def initialize
    @engine1 = Engine.new
    @engine2 = Engine.new
    @engine1 = Engine.new
    @engine2 = Engine.new
  end
end

car = Car.new
n = 50000
array = []
Benchmark.bm do |x|
  x.report("insertions") do
    n.times do
      array << car.dump.inserted_id.to_s
    end
  end

  x.report("loads") do
    n.times do |i|
      Car.find(array[i])
    end
  end
end
