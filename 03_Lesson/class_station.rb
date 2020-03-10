# Класс Station (Станция):
#  Имеет название, которое указывается при ее создании.
#  Может принимать поезда (по одному за раз).
#  Может возвращать список всех поездов на станции, находящиеся в текущий момент
#  Может возвращать список поездов на станции по типу (см. ниже):
# кол-во грузовых, пассажирских.
#  Может отправлять поезда (по одному за раз, при этом, поезд удаляется из
# списка поездов, находящихся на станции).
class Station
  attr_reader :trains
  def initialize(name)
    @name = name
    @trains = []
    @freight = []
    @passenger = []
  end

  def arrive(train = 1)
    @trains << train
  end

  def train

  end

  def return_type

  end

  def send
    @trains = @trains.size - 1
  end
end

class Train
  attr_reader :number
  def initialize(number)
    @number = number
  end
end
