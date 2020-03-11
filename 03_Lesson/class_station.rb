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

  # Метод send может отправлять поезда (по одному за раз,при этом,
  # поезд удаляется из списка поездов(@trains), находящихся на станции).
  def send
    @trains.shift
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
  attr_reader :first, :last
  def initialize(first, last)
    @first = first
    @last = last
    @intermediate = [@first, @last]
  end

  # Метод intermediate может добавлять промежуточную станцию в список
  def intermediate(station)
    @intermediate.insert(-2, station)
  end

  # Может удалять промежуточную станцию из списка
  def delet_intermediate(station)
    @intermediate.delete(station)
  end

  # Может выводить список всех станций по-порядку от начальной до конечной
  def puts_station
    @intermediate.each { |station| puts station }
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
  attr_reader :number, :type, :wagons
  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @station = []
    @marshrut = []
  end

  # Может набирать скорость
  def speed_gain(speed)
    @speed = speed
  end

  # Может возвращать текущую скорость
  def current_speed
    @speed
  end

  # Может тормозить (сбрасывать скорость до нуля)
  def stop
    @speed = 0
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию,
  # метод просто увеличивает или уменьшает количество вагонов)
  # прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  # параметры ('minus' - удаляет вагон, 'plus' - прибавляет вагон)
  def hitch_wagon(minusplus)
    if minusplus == 'minus' && @speed.zero?
      @wagons -= 1
    elsif minusplus == 'plus' && @speed.zero?
      @wagons += 1
    end
  end

  # Может принимать маршрут следования (объект класса Route).
  def route(route)
    @route = route
    @station = route.first
  end

  # Может перемещаться между станциями, указанными в маршруте.
  # Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def move(nazadvpered)
    if nazadvpered == 'nazad'
      @intermediate.rotate!(-1).first
    elsif nazadvpered == 'vpered'
      @intermediate.rotate!(1).first
    end
  end
end
