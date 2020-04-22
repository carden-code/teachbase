require_relative 'instance_counter'
require_relative 'validation'

# Класс Station (Станция):
#  Имеет название, которое указывается при ее создании.
#  Может принимать поезда (по одному за раз).
#  Может возвращать список всех поездов на станции, находящиеся в текущий момент
#  Может возвращать список поездов на станции по типу (см. ниже):
# кол-во грузовых, пассажирских.
#  Может отправлять поезда (по одному за раз, при этом, поезд удаляется из
# списка поездов, находящихся на станции).
class Station
  # Подключение модуля InstanceCounter.
  include InstanceCounter
  # Описание находиoaтся в модуле.
  include Validation

  @@all_stations = []

  # Метод self.all возвращает все станции(объекты), созданные на данный момент.
  def self.all
    @@all_stations
  end

  # Метод trains может возвращать список всех поездов на станции, находящиеся в
  # текущий момент.
  # Метод name может возвращать название станции
  attr_reader :trains, :name

  validate :name, :doubling, :@@all_stations
  validate :name, :presence
  validate :name, :capitalize


  def initialize(name)
    @name = name
    validate!
    @@all_stations << self
    @trains = []
    # Метод register_instance - описание в модуле InstanceCounter.
    register_instance
  end

  # Метод arrive принимает  параметр в виде объекта train.
  # Метод проверяет есть ли в массиве @trains переданный в метод объект (train)
  # если есть то метод возвращает nil, если нет
  # происходит добавление в массив @trains полученного параметра (Объект train).
  def arrive(train)
    @trains << train unless trains.include?(train)
  end

  # Метод list_trains принимает блок и проходит по всем поездам на станции,
  # передавая каждый поезд в блок.
  def list_trains
    trains.each { |train| yield(train) }
  end

  # Метод return_type может возвращать список поездов на станции по типу:
  # кол-во (cargo, pass).
  def return_type(type)
    @trains.select { |train| train.type == type }
  end

  # Метод delete может отправлять поезда (по одному за раз,при этом,
  # поезд удаляется из списка поездов(@trains), находящихся на станции).
  def delete(train)
    @trains.delete(train)
  end
end
