# Класс PassengerWagon (Пассажирский Вагон):
# Имеет номер (number - указывается при создании экземпляра)
# и тип (passw - пасажирский вагон).
# Может возвращать тип (type).
class PassengerWagon
  attr_reader :type
  def initialize(number, type = 'passw')
    @number = number
    @type = type
  end
end
