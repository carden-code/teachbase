# Класс CargoWagon (Грузовой Вагон):
# Имеет номер (number - указывается при создании экземпляра)
# и тип (cargow - грузовой вагон).
# Может возвращать тип (type).
class CargoWagon
  attr_reader :type
  def initialize(number, type = 'cargow')
    @number = number
    @type = type
  end
end
