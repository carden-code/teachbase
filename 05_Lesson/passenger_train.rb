# Класс PassengerTrain (Пассажирский Поезд):
# Имеет номер (произвольная строка) - указывается при создании экземпляра класса
# Имеет тип (pass - пассажирский)
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать список вагонов
# Может прицеплять/отцеплять вагоны по одному вагону за операцию,
# метод принимает в качестве параметра (объект класса PassengerWagon)
# и добавляет массив @wagons.
# прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route).
# При назначении маршрута поезду, поезд автоматически помещается
# на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте.
# Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Может возвращать предыдущую станцию, текущую, следующую, на основе маршрута
class PassengerTrain < Train
  @instances ||= 0
  def initialize(name)
    super name, 'pass'
  end

  # Метод attach_wagon может прицеплять вагоны (по одному вагону
  # за операцию, метод добавляет экземпляр класса PassengerWagon в массив)
  # прицепка вагонов может осуществляться только если поезд не движется.
  def attach_wagon(wagon)
    super if @type == wagon.type
  end
end
