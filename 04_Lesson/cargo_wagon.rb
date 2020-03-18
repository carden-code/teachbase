# Класс CargoWagon (Грузовой Вагон):
# Класс CargoWagon наследуется от класса Wagon
# Имеет номер (number - указывается при создании экземпляра)
# Имеет тип при создании экземпляра (cargow - грузовой вагон).
# Может возвращать тип (type).
class CargoWagon < Wagon
  super
  def initialize
    @type = 'cargow'
  end
end
