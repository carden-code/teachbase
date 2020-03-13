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
    return if trains.include?(train)
    @trains << train
  end

  # Может возвращать список поездов на станции по типу:
  # кол-во (cargo, passengers)
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

  # Метод intermediate может добавлять промежуточную станцию в список
  def intermediate(station)
    if @stations.include? station
      return
    else
      @stations.insert(-2, station)
    end
  end

  # Может удалять промежуточную станцию из списка
  def delet_intermediate(station)
    if station != @stations.first && station != @stations.last
      @stations.delete(station)
    end
  end

  # Может выводить список всех станций по-порядку от начальной до конечной
  def puts_station
    @stations.each { |station| puts station }
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
  # Метод type возвращает тип поезда (cargo, passengers).
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

  # Может набирать скорость
  def speed_gain(speed)
    if speed > 0 && speed != @current_speed && speed > @speed
      @current_speed = speed
    end
  end

  # Может тормозить (сбрасывать скорость до нуля)
  def stop(speed)
    if speed < @current_speed && speed >= 0
      @current_speed = speed
    end
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию,
  # метод просто увеличивает или уменьшает количество вагонов)
  # прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  # параметры ('minus' - удаляет вагон, 'plus' - прибавляет вагон)
  def hitch_wagon(minusplus)
    if minusplus == 'minus' && @current_speed.zero?
      @wagons -= 1
    elsif minusplus == 'plus' && @current_speed.zero?
      @wagons += 1
    end
  end

  # Может принимать маршрут следования (объект класса Route).
  # При назначении маршрута поезду, поезд автоматически помещается
  # на первую станцию в маршруте.
  def route(route)
    @route = route
    @station = @route.stations.first
  end

  # Может перемещаться между станциями, указанными в маршруте.
  # Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def move(nazadvpered)
    if nazadvpered == 'nazad' && @current_speed > 0
      @station = @route.stations.rotate!(-1).first
    elsif nazadvpered == 'vpered' && @current_speed > 0
      @station = @route.stations.rotate!(1).first
    end
  end

 # Может возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def return_station(predteksled)
    if pns == 'tek'
      @station
    elsif pns == 'pred'
      @route.stations.rotate(-1).first
    elsif pns == 'sled'
      @route.stations.rotate(1).first
    end
  end
end
