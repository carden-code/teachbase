# Класс PassengerWagon (Пассажирский Вагон):
# Класс PassengerWagon наследуется от класса Wagon.
# Имеет номер (number - указывается при создании экземпляра).
# Имеет тип при создании экземпляра (passw - пасажирский вагон).
# Может возвращать тип (type).
class PassengerWagon < Wagon
  # Метод seat возвращает колличество свободных мест.
  attr_reader :seat
  def initialize(seat)
    super 'pass'
    @seat = seat
    @occupied = 0
  end

  # Метод take_seat "занимает места" в вагоне (по одному за раз).
  def take_seat
    @seat -= 1
    @occupied += 1
  end

  # Метод number_occupied_seats возвращает кол-во занятых мест в вагоне
  def number_occupied_seats
    @occupied
  end
end
