# Класс Station (Станция):
#  Имеет название, которое указывается при ее создании.
#  Может принимать поезда (по одному за раз).
#  Может возвращать список всех поездов на станции, находящиеся в текущий момент
#  Может возвращать список поездов на станции по типу (см. ниже):
# кол-во грузовых, пассажирских.
#  Может отправлять поезда (по одному за раз, при этом, поезд удаляется из
# списка поездов, находящихся на станции).
class Station
  # Метод trains может возвращать список всех поездов на станции, находящиеся в
  # текущий момент.
  attr_reader :trains
  def initialize(name)
    @name = name
    @trains = []
  end

  # Метод arrive принимает  параметр в виде объекта train.
  # Метод проверяет есть ли в массиве @trains переданный в метод объект (train)
  # если есть то метод возвращает nil, если нет
  # происходит добавление в массив @trains полученного параметра (Объект train).
  def arrive(train)
    @trains << train unless trains.include?(train)
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

# Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываютсся при создании маршрута,
# а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной
class Route
  attr_reader :stations
  def initialize(first, last)
    @stations = [first, last]
  end

  # Метод midway может добавлять промежуточную станцию в список
  def midway(station)
    @stations.insert(-2, station) unless @stations.include? station
  end

  # Метод first_station? проверяет является ли сатнция первой.
  def first_station?(station)
    station == @stations.first
  end

  # Метод last_station? проверяет является ли сатнция последней.
  def last_station?(station)
    station == @stations.last
  end

  # Метод delete_midway может удалять промежуточную станцию из списка.
  def delete_midway(station)
    unless first_station?(station) || last_station?(station)
      @stations.delete(station)
    end
  end

  # Метод list_stations Может выводить список всех станций по-порядку
  # от начальной до конечной.
  def list_stations
    @stations.each { |name| puts name }
  end
end


# Класс Train (Поезд):
# Имеет номер (произвольная строка) и тип (грузовой, пассажирский)
# и количество вагонов, эти данные указываются при создании экземпляра класса
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто
# увеличивает или уменьшает количество вагонов)
# прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route).
# При назначении маршрута поезду, поезд автоматически помещается
# на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте.
# Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Может возвращать предыдущую станцию, текущую, следующую, на основе маршрута
class Train
  # Метод number возвращает номер поезда.
  # Метод type возвращает тип поезда (cargo, pass).
  # Метод wagons возвращает колличество вагоно поезда.
  # Метод station может возвращать текущую станцию.
  # Метод current_speed может возвращать текущую скорость.
  attr_reader :number, :type, :wagons, :station, :current_speed
  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @current_speed = 0
    @station = station
  end

  # Метод speed_gain может набирать скорость.
  def accelerate(value)
    @current_speed += value if value.positive?
  end

  # Метод stop может тормозить (сбрасывать скорость до нуля).
  def decelerate(value)
    @current_speed -= value if value <= @current_speed && value.positive?
  end

  # Метод uncouple_wagon может отцеплять вагоны (по одному вагону
  # за операцию, метод просто уменьшает количество вагонов)
  # отцепка вагонов может осуществляться только если поезд не движется.
  def uncouple_wagon
    @wagons -= 1 if @current_speed.zero? && @wagons.positive?
  end

  # Метод hitch_wagon может прицеплять вагоны (по одному вагону
  # за операцию, метод просто увеличивает количество вагонов)
  # прицепка вагонов может осуществляться только если поезд не движется.
  def hitch_wagon
    @wagons += 1 if @current_speed.zero?
  end

  # Метод route может принимать маршрут следования (объект класса Route).
  # При назначении маршрута поезду, поезд автоматически помещается
  # на первую станцию в маршруте.
  def route(route)
    @route = route
    @station = @route.stations.first
  end

  # Метод move может перемещаться между станциями, указанными в маршруте.
  # Перемещение возможно вперед - 'forth' и назад - 'back',
  # но только на 1 станцию за раз.
  def move(backforth)
    if backforth == 'back' && @current_speed > 0
      @station = @route.stations.rotate!(-1).first
    elsif backforth == 'forth' && @current_speed > 0
      @station = @route.stations.rotate!(1).first
    end
  end

  # Метод return_station может возвращать предыдущую станцию - 'previous',
  # текущую - 'current', следующую -'next', на основе маршрута.
  def return_station(previouscurrentnext)
    if previouscurrentnext == 'current'
      @station
    elsif previouscurrentnext == 'previous'
      @route.stations.rotate(-1).first
    elsif previouscurrentnext == 'next'
      @route.stations.rotate(1).first
    end
  end
end
