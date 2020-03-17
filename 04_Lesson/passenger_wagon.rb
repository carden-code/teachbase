class PassengerWagon
  attr_reader :type
  def initialize(number, type = 'pass')
    @number = number
    @type = type
  end
end
