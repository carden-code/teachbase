class CargoWagon
  attr_reader :type
  def initialize(number, type = 'cargo')
    @number = number
    @type = type
  end
end
