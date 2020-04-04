require_relative 'module_company'
require_relative 'instance_counter'

# Класс Wagon (Вагон):
# Имеет тип (указывается при создании экземпляра)
# Может возвращать тип
class Wagon
  # Подключение модуля Company.
  include Company
  # метод type возвращает type объекта.
  # Метод capacity возвращает доступную вместимость.
  # Метод occupied возвращает кол-во занятого места в вагоне.
  attr_reader :type, :capacity, :occupied
  def initialize(type, capacity)
    @capacity = capacity.to_i
    @type = type
    validate!
    @occupied = 0
  end

  # Метод valid? проверяет валидность объекта.
  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  # Приватный метод validate! выбрасывает исключение
  # если есть несоответствие условию.
  def validate!
    raise 'Ошибка! Тип не указан!' if @type.nil? || @type.empty?
    raise 'Ошибка! Вместимость должна быть больше 0!' unless @capacity.positive?
  end
end
