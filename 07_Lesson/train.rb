require_relative 'instance_counter'
require_relative 'module_company'

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
  # Описание находится в модуле.
  include Company
  # Описание находится в модуле.
  include InstanceCounter

  # Константа NUMBER_FORMAT - содержит шаблон(регулярное выражение).
  NUMBER_FORMAT = /^[a-z\d]{3}-*[a-z\d]{2}$/i
  # @@trains содержит всё созданные на данный момент объекты класса Train.
  @@trains = {}

  # Метод класса find, принимает номер поезда (указанный при его создании)
  # и возвращает объект поезда по номеру или nil,
  # если поезд с таким номером не найден.
  def self.find(name)
    @@trains[name]
  end

  # Метод number возвращает номер поезда.
  # Метод type возвращает тип поезда (cargo, pass).
  # Метод wagons возвращает колличество вагоно поезда.
  # Метод current_station может возвращать текущую станцию.
  # Метод current_speed может возвращать текущую скорость.
  attr_reader :name, :type, :wagons, :current_station, :current_speed
  def initialize(name, type)
    @@trains[name] = self
    @name = name.to_s
    validate!
    @type = type
    @wagons = []
    @current_speed = 0
    # Метод register_instance модуля InstanceCounter (Описание в модуле).
    register_instance
  end

  # Метод list_wagons принимает блок и проходит по всем вагонам поезда,
  # передавая каждый объект вагона в блок.
  def list_wagons
    wagons.each_with_index { |wagon, index| yield(wagon, index) }
  end

  # Метод valid? проверяет валидность объекта.
  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  # Метод attach_wagon может прицеплять вагоны (по одному вагону
  # за операцию) В качестве параметра принимает объекты класса (PassengerWagon и
  # CargoWagon).
  # Прицепка вагонов может осуществляться только если поезд не движется.
  def attach_wagon(wagon)
    return if @wagons.include? wagon
    @wagons << wagon if @current_speed.zero?
  end

  # Метод detach_wagon может отцеплять вагоны (Удалять вагоны из массива
  # по одному вагону за операцию)
  # отцепка вагонов может осуществляться только если поезд не движется.
  def detach_wagon
    @wagons.pop if @current_speed.zero?
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

  protected

  # Метод accelerate может набирать скорость.
  def accelerate(value)
    @current_speed += value if value.positive?
  end

  # Метод decelerate может тормозить (сбрасывать скорость до нуля).
  def decelerate(value)
    @current_speed -= value if value <= @current_speed && value.positive?
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

  private

  # Приватный метод validate! выбрасывает исключение
  # если есть несоответствие условию.
  def validate!
    raise 'Ошибка! Не правильный формат номера!' if name !~ NUMBER_FORMAT
  end
end
