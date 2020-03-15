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
  # Метод name может возвращать название станции
  attr_reader :trains, :name
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
  # Метод stations возвращает все станции в маршруте
  attr_reader :stations
  def initialize(first, last)
    @stations = [first, last]
  end

  # Метод midway может добавлять промежуточную станцию в список
  def midway(station)
    @stations.insert(-2, station) unless @stations.include? station
  end

  # Метод delete_midway может удалять промежуточную станцию из списка.
  def delete_midway(station)
    if station != @stations.first && station != @stations.last
      @stations.delete(station)
    end
  end

  # Метод list_stations Может выводить список всех станций по-порядку
  # от начальной до конечной.
  def list_stations
    @stations.each { |item| puts item.name }
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
  # Метод current_station может возвращать текущую станцию.
  # Метод current_speed может возвращать текущую скорость.
  attr_reader :number, :type, :wagons, :current_station, :current_speed
  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @current_speed = 0
    @current_station = current_station
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
  def detach_wagon
    @wagons -= 1 if @current_speed.zero? && @wagons.positive?
  end

  # Метод hitch_wagon может прицеплять вагоны (по одному вагону
  # за операцию, метод просто увеличивает количество вагонов)
  # прицепка вагонов может осуществляться только если поезд не движется.
  def attach_wagon
    @wagons += 1 if @current_speed.zero?
  end

  # Метод route может принимать маршрут следования (объект класса Route).
  # При назначении маршрута поезду, поезд автоматически помещается
  # на первую станцию в маршруте.
  def route(route)
    @route = route
    @current_station = @route.stations.first
  end

  # Метод moving_forward может перемещаться между станциями, указанными в
  # маршруте. Перемещение возможно вперед, но только на 1 станцию за раз.
  def move_forwards
    @current_station = @route.stations.rotate!(1).first
  end

  # Метод moving_back может перемещаться между станциями, указанными в
  # маршруте. Перемещение возможно назад, но только на 1 станцию за раз.
  def move_bycwards
    @current_station = @route.stations.rotate!(-1).first
  end

  # Метод previous_station может возвращать предыдущую станцию маршрута.
  def previous_station
    @route.stations.rotate(-1).first if @current_station != @route.stations.first
  end

  # Метод next_station может возвращать предыдущую станцию маршрута.
  def next_station
    @route.stations.rotate(1).first if @current_station != @route.stations.last
  end
end
