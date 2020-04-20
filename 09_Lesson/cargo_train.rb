# Класс CargoTrain (Грузовой Поезд):
# Имеет номер (произвольная строка) - указывается при создании экземпляра класса
# Имеет тип (pass - пассажирский)
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать список вагонов
# Может прицеплять/отцеплять вагоны по одному вагону за операцию,
# метод принимает в качестве параметра (объект класса CargoWagon)
# и добавляет массив @wagons.
# прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route).
# При назначении маршрута поезду, поезд автоматически помещается
# на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте.
# Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Может возвращать предыдущую станцию, текущую, следующую, на основе маршрута
class CargoTrain < Train
  validate :name, :type, String
  validate :name, :presence
  validate :name, :format, /^[a-z\d]{3}-*[a-z\d]{2}$/i
  # validate :name, :time

  def initialize(name)
    super name, 'cargo'
  end

  # Метод attach_wagon может прицеплять вагоны (по одному вагону
  # за операцию, метод добавляет экземпляр класса CargoWagon в массив)
  # прицепка вагонов может осуществляться только если поезд не движется.
  def attach_wagon(wagon)
    super if @type == wagon.type
  end
end
