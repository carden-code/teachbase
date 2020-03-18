# Класс Wagon (Вагон):
# Имеет тип (указывается при создании экземпляра)
# Может возвращать тип
class Wagon
  attr_reader :type
  def initialize(type)
    @type = type
  end
end
