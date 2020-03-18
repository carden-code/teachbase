# Класс PassengerWagon (Пассажирский Вагон):
# Класс PassengerWagon наследуется от класса Wagon.
# Имеет номер (number - указывается при создании экземпляра).
# Имеет тип при создании экземпляра (passw - пасажирский вагон).
# Может возвращать тип (type).
class PassengerWagon < Wagon
  super
  def initialize
    @type = 'pass'
  end
end
