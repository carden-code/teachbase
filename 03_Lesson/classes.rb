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
    # Защита (guard clause) от стирания первой и последней станции.
    return unless (@stations.first || @stations.last) != station

    # Удаление промежуточной станции из списка.
    @stations.delete(station)
  end

  # Метод list_stations Может выводить список всех станций по-порядку
  # от начальной до конечной.
  def list_stations
    @stations.each { |item| puts "#{item.name}, #{item}" }
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
  end

  # Метод accelerate может набирать скорость.
  def accelerate(value)
    @current_speed += value if value.positive?
  end

  # Метод decelerate может тормозить (сбрасывать скорость до нуля).
  def decelerate(value)
    @current_speed -= value if value <= @current_speed && value.positive?
  end

  # Метод attach_wagon может прицеплять вагоны (по одному вагону
  # за операцию, метод просто увеличивает количество вагонов)
  # прицепка вагонов может осуществляться только если поезд не движется.
  def attach_wagon
    @wagons += 1 if @current_speed.zero?
  end

  # Метод detach_wagon может отцеплять вагоны (по одному вагону
  # за операцию, метод просто уменьшает количество вагонов)
  # отцепка вагонов может осуществляться только если поезд не движется.
  def detach_wagon
    @wagons -= 1 if @current_speed.zero? && @wagons.positive?
  end

  # Метод route может принимать маршрут следования (объект класса Route).
  # При назначении маршрута поезду, поезд автоматически помещается
  # на первую станцию в маршруте.
  def route(route)
    @route = route
    @current_station = @route.stations.first
    @current_station.arrive(self)
  end

  # Метод move_forwards может перемещаться между станциями, указанными в
  # маршруте. Перемещение возможно вперед, но только на 1 станцию за раз.
  def move_forwards
    # Защита (guard clause) от отсутствия route
    return unless @current_station

    # Получаем значение индекса актуальной станции из массива stations.
    current_index = @route.stations.find_index(@current_station)

    # Защита (guard clause) от переполнения значения индекса массива stations.
    return unless current_index + 1 < @route.stations.count

    # Убытие поезда с актуальной станции, где self это текущий экземпляр
    # класса Train.
    @current_station.delete(self)

    # Смена актуальной станции на следующую становящуюся актуальной.
    @current_station = @route.stations[current_index + 1]
    # Прибытие поезда на следующую станцию, где self это текущий экземпляр
    # класса Train.
    @current_station.arrive(self)
  end

  # Метод move_backwards может перемещаться между станциями, указанными в
  # маршруте. Перемещение возможно назад, но только на 1 станцию за раз.
  def move_backwards
    # Защита (guard clause) от отсутствия route.
    return unless @current_station

    # Получаем значение индекса актуальной станции из массива stations.
    current_index = @route.stations.find_index(@current_station)

    # Защита (guard clause) от перехода на следующую станцию
    # если текущая станция первая.
    return unless current_index - 1 >= 0

    # Убытие поезда с актуальной станции, где self это текущий экземпляр
    # класса Train.
    @current_station.delete(self)

    # Смена актуальной станции на следующую станцию.
    @current_station = @route.stations[current_index - 1]
    # Прибытие поезда на следующую станцию, где self это текущий экземпляр
    # класса Train.
    @current_station.arrive(self)
  end

  # Метод next_station может возвращать следующую станцию маршрута.
  def next_station
    # Защита (guard clause) от отсутствия route.
    return unless @current_station

    # Получаем значение индекса актуальной станции из массива stations.
    current_index = @route.stations.find_index(@current_station)

    # Защита (guard clause) от перехода на следующую станцию
    # если текущая станция последняя.
    return unless @current_station != @route.stations.last

    # Возвращает следующую станцию маршрута.
    @route.stations[current_index + 1]
  end

  # Метод previous_station может возвращать предыдущую станцию маршрута.
  def previous_station
    # Защита (guard clause) от отсутствия route.
    return unless @current_station

    # Получаем значение индекса актуальной станции из массива stations.
    current_index = @route.stations.find_index(@current_station)

    # Защита (guard clause) от перехода на предыдущую станцию
    # если текущая станция первая.
    return unless @current_station != @route.stations.first

    # Возвращает предыдущую станцию маршрута.
    @route.stations[current_index - 1]
  end
end
