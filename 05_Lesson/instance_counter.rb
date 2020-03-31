#
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  #
  module ClassMethods
    def instances
      @instances
    end

    def register_count
      @instances += 1
    end
  end

  #
  module InstanceMethods
    private

    def register_instance
      self.class.register_count
    end
  end
end
