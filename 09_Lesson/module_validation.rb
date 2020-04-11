#
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  #
  module ClassMethods
    attr_reader :validatons

    def validate(name, check, *args)
      @validations ||= []
      @validations << { name: name, check: check, args: args }
    end
  end

  #
  module InstanceMethods
    def validate!
      self.class.instance_variable_get(:@validations).each do |validation|
        name = validation[:name]
        argument = validation[:args].first
        value = instance_variable_get("@#{name}".to_sym)
        send "validate_#{validation[:check]}".to_sym, name, value, argument
      end
    end

    def validate_presence(name, value, _arg)
      raise "#{name} Не может быть пустой!" if value.nil? || value.eql?('')
    end
  end
end
