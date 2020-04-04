# Класс CargoWagon (Грузовой Вагон):
# Класс CargoWagon наследуется от класса Wagon
# Имеет номер (number - указывается при создании экземпляра)
# Имеет тип при создании экземпляра (cargow - грузовой вагон).
# Может возвращать тип (type).
class CargoWagon < Wagon
  # Метод takes возвращает занятый объем.
  attr_reader :takes
  def initialize(capacity)
    super 'cargo', capacity
    validate!
    @takes = 0
  end

  # Метод takes_volume "занимает объем" в вагоне.
  def takes_volume(capacity)
    return if @capacity < capacity || capacity <= 0
    @capacity -= capacity
    @takes += capacity
  end
end
