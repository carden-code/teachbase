require_relative 'instance_counter'

# Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываютсся при создании маршрута,
# а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список.
# Может удалять промежуточную станцию из списка.
# Может выводить список всех станций по-порядку от начальной до конечной.
class Route
  # Подключение модуля InstanceCounter.
  include InstanceCounter
  # Метод stations возвращает все станции в маршруте.
  attr_reader :stations
  def initialize(first, last)
    @stations = [first, last]
    validate!
    register_instance
  end

  # Метод midway может добавлять промежуточную станцию в список.
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
