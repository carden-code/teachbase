# Класс CargoWagon (Грузовой Вагон):
# Класс CargoWagon наследуется от класса Wagon
# Имеет номер (number - указывается при создании экземпляра)
# Имеет тип при создании экземпляра.
# Может возвращать тип (type).
class CargoWagon < Wagon
  def initialize(capacity)
    super 'cargo', capacity
  end

  # Метод takes_volume "занимает объем" в вагоне.
  def takes_volume(capacity)
    return if @capacity < capacity || capacity <= 0
    @capacity -= capacity
    @occupied += capacity
  end
end
