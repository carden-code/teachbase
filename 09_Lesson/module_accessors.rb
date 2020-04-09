#
module Accessor
  def attr_accessor_with_history(*names)
    names.each do |name|
      # Переменная var_name = имя преданное в блок и становится символом
      var_name = "@#{name}".to_sym
      # Переменная var_history = имя преданное в блок и становится символом
      var_history = "@#{name}_history".to_sym
      # Создаётся метод геттер с именем переданным в блок
      define_method(name.to_sym) { instance_variable_get(var_name) }
      # Создаётся метод геттер с именем переданным в блок +_history
      define_method("#{name}_history".to_sym) { instance_variable_get(var_history) }
      # Создаётся метод с именем переданным в блок + = и принимает блок значениe
      define_method("#{name}=".to_sym) do |value|
        # Переменная history = значнию интсанс_гет или пустому массиву если значения нет
        history = instance_variable_get("@#{name}_history") || []
        # В эту инстанс переменную "@#{name}_history" сохраняются значения инстанс переменной var_name
        history << instance_variable_get(var_name)
        # Этот метод присваивает значение переменной var_name
        instance_variable_set(var_name, value)
        # Этот метод присваивает значение переменной var_history
        instance_variable_set(var_history, history)
      end
    end
  end

  #
#   def strong_attr_accessor(name, type)
#     var_name = "@#{name}".to_sym
#     define_method(name.to_sym) { instance_variable_get(var_name) }
#     var_name.class == type.class
#   rescue StandardError => e
#     puts e.inspect
#     define_method("#{name}=".to_sym) { |type| instance_variable_set(var_name, type) }
#   end
# end

class X
  extend Accessor
  attr_accessor_with_history :a, :b, :c
end
