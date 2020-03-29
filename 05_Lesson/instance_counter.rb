#
module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  #
  module ClassMethods
    def instance_count
      @@instances = 0
    end

    def instances
      @@instances
    end
  end

  #
  module InstanceMethods

    protected

    def register_instance
      self.class.instance_count
    end
  end
end
