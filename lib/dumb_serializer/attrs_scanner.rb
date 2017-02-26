# frozen_string_literal: true
module DumbSerializer
  class AttrsScanner
    class CoreTypeScanError < StandardError; end

    def initialize(object)
      @object = object
    end

    def scan
      raise CoreTypeScanError if belongs_to_core?
      recursive_build
    end

    private

    def object_attrs
      object.instance_variables.each_with_object({}) do |attr, hash|
        hash[attr.to_s.delete('@').to_sym] = object.instance_variable_get(attr)
      end
    end

    def decompose(attrs)
      attrs.each do |name, value|
        self.object = value

        next if belongs_to_core?
        attrs[name] = nested? ? recursive_build : non_variable_instance
      end
    end

    def recursive_build
      { dd_class: object_class, dd_vars: decompose(object_attrs) }
    end

    def non_variable_instance
      { dd_class: object_class }
    end

    def object_class
      object.class.to_s
    end

    def belongs_to_core?
      CORE_TYPES.include?(object.class)
    end

    def nested?
      object.instance_variables.any?
    end

    attr_accessor :object
  end
end
