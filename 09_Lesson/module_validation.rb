# frozen_string_literal: true

# module Validation
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # module ClassMethods
  module ClassMethods
    attr_reader :checks

    def validate(attr, kind, *params)
      @checks ||= {}
      @checks[attr] ||= []
      @checks[attr] << { kind: kind, params: params }
    end
  end

  # moduele InstanceMethods
  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate_presence(name, value, _params)
      raise "'#{name}' is nil or empty!" if value.nil? || value == ''
    end

    def validate_type(name, value, params)
      raise "'#{name}' is't '#{params.first}'" if value.class != params.first
    end

    def validate_format(name, value, params)
      raise "'#{name}' have wrong format '#{params[1]}'" if value !~ params[0]
    end

    def validate_range(name, value, _params)
      value = value.to_i
      raise "'#{name}' is not a digit! Re-enter a digital value!" if value.zero?
      raise "Out of '#{name}', please try again!" if value.negative?
    end

    def validate_doubling(name, value, _params)
      self.class.class_variable_get(:@@all_stations).each do |station|
        raise "'#{name}' is already exists! Re-enter." if value == station.name
      end
    end

    def validate!
      self.class.checks.each do |attr_name, attr_validations|
        value = instance_variable_get("@#{attr_name}".to_sym)
        attr_validations.each do |attributes|
          send("validate_#{attributes[:kind]}", attr_name, value, attributes[:params])
        end
      end
    end
  end
end




# #
# module Validation
#   def self.included(base)
#     base.extend ClassMethods
#     base.send :include, InstanceMethods
#   end
#
#   #
#   module ClassMethods
#     attr_reader :validatons
#
#     def validate(name, check, *args)
#       @validations ||= []
#       @validations << { name: name, check: check, args: args }
#     end
#   end
#
#   #
#   module InstanceMethods
#     def validate!
#       self.class.instance_variable_get(:@validations).each do |validation|
#         name = validation[:name]
#         argument = validation[:args].first
#         value = instance_variable_get("@#{name}".to_sym)
#         send "validate_#{validation[:check]}".to_sym, name, value, argument
#       end
#     end
#
#     def validate_presence(name, value, _arg)
#       raise "#{name} Не может быть пустой!" if value.nil? || value.eql?('')
#     end
#   end
# end
