require_relative 'module_company'

# Класс Wagon (Вагон):
# Имеет тип (указывается при создании экземпляра)
# Может возвращать тип
class Wagon
  # Подключение модуля Company.
  include Company
  # метод type возвращает type объекта.
  attr_reader :type
  def initialize(type)
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

  private

  # Приватный метод validate! выбрасывает исключение
  # если есть несоответствие условию.
  def validate!
    raise 'Ошибка! Тип не указан!' if @type.nil? || @type.empty?
  end
end
