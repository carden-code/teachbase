class CargoTrain < Train
  def initialize(number, type = 'cargo')
    super
  end
  # Метод attach_wagon может прицеплять вагоны (по одному вагону
  # за операцию, метод добавляет экземпляр класса CargoWagon в массив)
  # прицепка вагонов может осуществляться только если поезд не движется.
  def attach_wagon(cargowagon)
    return unless cargowagon.type != 'pass'
    @wagons << cargowagon if @current_speed.zero?
  end

  # Метод detach_wagon может отцеплять вагоны (по одному вагону
  # за операцию)
  # отцепка вагонов может осуществляться только если поезд не движется.
  def detach_wagon
    @wagons.pop if @current_speed.zero?
  end
end
