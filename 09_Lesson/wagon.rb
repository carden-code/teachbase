require_relative 'module_company'
require_relative 'module_accessors'
require_relative 'validation'

# Класс Wagon (Вагон):
# Имеет тип (указывается при создании экземпляра)
# Может возвращать тип
class Wagon
  # Подключение модуля Company.
  include Accessor
  # Подключение модуля Company.
  include Company
  # Описание находиoaтся в модуле.
  include Validation

  # метод type возвращает type объекта.
  # Метод capacity возвращает доступную вместимость.
  # Метод occupied возвращает кол-во занятого места в вагоне.
  attr_reader :type, :capacity, :free_capacity

  attr_accessor_with_history :color

  def initialize(type, capacity)
    @capacity = capacity.to_i
    @type = type
    validate!
    @free_capacity = @capacity
  end

  def loaded_capacity
    @capacity - @free_capacity
  end
end
