# Класс PassengerWagon (Пассажирский Вагон):
# Класс PassengerWagon наследуется от класса Wagon.
# Имеет номер (number - указывается при создании экземпляра).
# Имеет тип при создании экземпляра.
# Может возвращать тип (type).
class PassengerWagon < Wagon
  def initialize(capacity)
    super 'pass', capacity
  end

  # Метод take_seat "занимает места" в вагоне (по одному за раз).
  def take_seat
    return if @capacity.zero?

    @capacity -= 1
    @occupied += 1
  end
end
