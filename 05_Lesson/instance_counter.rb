#
module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  #
  module ClassMethods
    @@instances ||= 0
    @@heirs_instances ||= 0

    def instances
      @@instances
    end

    def heirs_instances
      @@heirs_instances
    end

    def register_count
      @@instances += 1
    end

    def subclass_count
      @@heirs_instances += 1
    end
  end

  #
  module InstanceMethods

    private

    def register_instance
      self.class.register_count
    end

    def instance_register
      self.class.subclass_count
    end
  end
end
