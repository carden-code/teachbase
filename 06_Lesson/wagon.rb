require_relative 'module_company'
# Класс Wagon (Вагон):
# Имеет тип (указывается при создании экземпляра)
# Может возвращать тип
class Wagon
  include Company

  attr_reader :type
  def initialize(type)
    @type = type
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    raise 'Ошибка! Тип не указан!' if @type.nil? || @type.empty?
  end
end
