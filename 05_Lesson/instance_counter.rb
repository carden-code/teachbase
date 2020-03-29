#
module InstanceCounter
  def self.icluded(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  #
  module ClassMethods
    def instances
      @@instances
    end
  end

  #
  module InstanceMethods

    protected

    def register_instance
      @@instances += 1
    end
  end
end
