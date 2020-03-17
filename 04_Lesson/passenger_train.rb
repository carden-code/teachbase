class PassengerTrain < Train
  def initialize(number, type = 'pass')
    super
  end

  # Метод attach_wagon может прицеплять вагоны (по одному вагону
  # за операцию, метод добавляет экземпляр класса PassengerWagon в массив)
  # прицепка вагонов может осуществляться только если поезд не движется.
  def attach_wagon(passengerwagon)
    return unless passengerwagon.type != 'cargo'
    super
  end
end
