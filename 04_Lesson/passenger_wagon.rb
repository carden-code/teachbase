class PassengerWagon
  attr_reader :type
  def initialize(number, type = 'passw')
    @number = number
    @type = type
  end
end
