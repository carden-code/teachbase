# Класс CargoWagon (Грузовой Вагон):
# Класс CargoWagon наследуется от класса Wagon
# Имеет номер (number - указывается при создании экземпляра)
# Имеет тип при создании экземпляра (cargow - грузовой вагон).
# Может возвращать тип (type).
class CargoWagon < Wagon
  # Метод volume возвращает оставшийся (доступный) объем.
  # Метод takes возвращает занятый объем.
  attr_reader :volume, :takes
  def initialize(volume)
    super 'cargo'
    @volume = volume
    @takes = 0
  end

  # Метод takes_volume "занимает объем" в вагоне.
  def takes_volume(volume)
    @volume -= volume
    @takes += volume
  end
end
