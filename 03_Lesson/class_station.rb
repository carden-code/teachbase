class Station
  attr_reader :trains
  def initialize(name)
    @name = name
    @trains = []
    @freight = []
    @passenger = []
  end

  def train(type, train = 1)
    @trains << train
    if type == 'freight'
      @freight << train
    else
      @passenger << train
    end
  end

  def type
    puts "freight trains in station - #{@freight.size}"
    puts "passenger trains in station - #{@passenger.size}"
  end

  def send
    @trains = @trains.size - 1
  end
end 
