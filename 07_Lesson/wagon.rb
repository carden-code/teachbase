require_relative 'module_company'

# Класс Wagon (Вагон):
# Имеет тип (указывается при создании экземпляра)
# Может возвращать тип
class Wagon
  # Подключение модуля Company.
  include Company
  # метод type возвращает type объекта.
  # Метод capacity возвращает доступную вместимость.
  attr_reader :type, :capacity
  def initialize(type, capacity)
    @capacity = capacity.to_i
    @type = type
    validate!
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
