# Класс CargoWagon (Грузовой Вагон):
# Класс CargoWagon наследуется от класса Wagon
# Имеет номер (number - указывается при создании экземпляра)
# Имеет тип при создании экземпляра.
# Может возвращать тип (type).
class CargoWagon < Wagon
  strong_attr_accessor :carriage_type, String

  validate :capacity, :range

  def initialize(capacity)
    super 'cargo', capacity
    validate!
  end

  # Метод takes_volume "занимает объем" в вагоне.
  def takes_volume(capacity)
    return unless capacity.positive? && capacity < @free_capacity

    @free_capacity -= capacity
  end
end
