#
module InstanceCounter

  #
  module ClassMethods
    def instances
      @@instances
    end
  end

  #
  module InstanceMethods
    def register_instance
    end
  end
end
