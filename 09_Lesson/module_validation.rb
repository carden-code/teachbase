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

    # def time_now
    #   Time.now.min
    # end
    #
    # def validate_time(name, value, _params)
    #   raise "#{name} - #{value} Можно создать только в чётные минуты!!!'" if time_now.odd?
    # end

    def validate_presence(name, value, _params)
      raise "'#{name}' nil или пустая строка!" if value.nil? || value.eql?('')
    end

    def validate_capitalize(name, value, _params)
      raise "#{name} Введите с большой буквы!" unless value == value.capitalize
    end

    def validate_type(name, value, params)
      raise "'#{name}' is't '#{params.first}'" if value.class != params.first
    end

    def validate_format(name, value, params)
      raise "'#{name}' Неверный формат! '#{params[1]}'" if value !~ params[0]
    end

    def validate_range(name, value, _params)
      value = value.to_i
      raise "'#{name}' is not a digit! Re-enter a digital value!" if value.zero?
      raise "Out of '#{name}', please try again!" if value.negative?
    end

    def validate_doubling(name, value, _params)
      self.class.class_variable_get(:@@all_stations).each do |station|
        raise "'#{name} ' Уже существует! Введите повторно!" if value == station.name
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
