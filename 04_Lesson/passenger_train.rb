class PassengerTrain < Train
  def initialize(number, type = 'pass')
    super
  end

  # Метод attach_wagon может прицеплять вагоны (по одному вагону
  # за операцию, метод добавляет экземпляр класса PassengerWagon в массив)
  # прицепка вагонов может осуществляться только если поезд не движется.
  def attach_wagon(passengerwagon)
    return unless passengerwagon.type != 'cargo'
    @wagons << passengerwagon if @current_speed.zero?
  end

  # Метод detach_wagon может отцеплять вагоны (по одному вагону
  # за операцию)
  # отцепка вагонов может осуществляться только если поезд не движется.
  def detach_wagon
    @wagons.pop if @current_speed.zero?
  end
end
