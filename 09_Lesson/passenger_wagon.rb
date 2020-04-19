# Класс PassengerWagon (Пассажирский Вагон):
# Класс PassengerWagon наследуется от класса Wagon.
# Имеет номер (number - указывается при создании экземпляра).
# Имеет тип при создании экземпляра.
# Может возвращать тип (type).
class PassengerWagon < Wagon
  validate :capacity, :range

  def initialize(capacity)
    super 'pass', capacity
  end

  # Метод take_seat "занимает места" в вагоне (по одному за раз).
  def take_seat
    return unless @capacity.positive?

    @free_capacity -= 1
  end
end
