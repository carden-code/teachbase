# Модуль Accessor Содержит два модуля.
# Модуль с методами класса и модуль с методами инстансов.
module Accessor
  def self.included(base)
    base.extend ClassMethods
  end

  # module ClassMethods
  module ClassMethods
    # Метод динамически создает геттеры и сеттеры для любого кол-ва атрибутов,
    # при этом сеттер сохраняет все значения инстанс-переменной при изменении
    # этого значения. Также  добавляется инстанс-метод который возвращает
    # массив всех значений данной переменной.
    def attr_accessor_with_history(*names)
      names.each do |name|
        # Переменная var_name = имя преданное в блок и становится символом.
        var_name = "@#{name}".to_sym
        # Переменная var_history = имя преданное в блок и становится символом.
        var_history = "@#{name}_history".to_sym

        # Создаётся метод геттер с именем переданным в блок.
        define_method(name.to_sym) { instance_variable_get(var_name) }
        # Создаётся метод геттер с именем переданным в блок +_history.
        define_method("#{name}_history".to_sym) { instance_variable_get(var_history) }

        # Создаётся метод с именем переданным в блок и принимает блок значениe.
        define_method("#{name}=".to_sym) do |value|
          # history = значнию интсанс_гет или пустому массиву если значения нет.
          history = instance_variable_get("@#{name}_history") || []
          # В переменную "history" сохраняется значение переменной var_name.
          history << instance_variable_get(var_name) unless instance_variable_get(var_name).nil?
          # Этот метод присваивает значение переменной var_name.
          instance_variable_set(var_name, value)
          # Этот метод присваивает значение переменной var_history.
          instance_variable_set(var_history, history)
        end
      end
    end

    # Метод который принимает имя атрибута и его класс. При этом создается геттер
    # и сеттер для одноименной инстанс-переменной, но сеттер проверяет тип
    # присваемого значения. Если тип отличается от того,
    # который указан вторым параметром, то выбрасывается исключение.
    # Если тип совпадает, то значение присваивается.
    def strong_attr_accessor(name, type)
      # Сохраняет в переменную имя атрибута и преобразует в символ.
      var_name = "@#{name}".to_sym

      # Создаётся метод геттер.
      define_method(name.to_sym) { instance_variable_get(var_name) }

      # Создаётся сеттер и присваивает значение если типы совпадают.
      define_method("#{name}=".to_sym) do |value|
        # Выбрасит исключение если классы не совпадают.
        raise TypeError, 'Неправильный тип аргумента!' unless value.class == type
        # Присваивает значение переданное в блок.
        instance_variable_set(var_name, value)
      end
    end
  end
end
