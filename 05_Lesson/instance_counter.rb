# модуль InstanceCounter, содержит методы класса и инстанс-методы,
# которые подключаются автоматически при вызове include в классе:
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # Модуль ClassMethods содержит методы класса.
  module ClassMethods
    # Метод instances возвращает кол-во экземпляров данного класса.
    def instances
      @instances
    end

    # Метод register_count прибавляет к инстанс переменно +1.
    def register_count
      @instances += 1
    end
  end

  # Модуль InstanceMethods создержит инстанс методы.
  module InstanceMethods
    private

    # Приватный метод register_instance увеличивает счетчик кол-ва экземпляров
    # класса и который можно вызвать из конструктора.
    def register_instance
      self.class.register_count
    end
  end
end
