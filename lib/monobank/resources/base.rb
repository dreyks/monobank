module Monobank
  module Resources
    class Base
      def self.define_fields(attributes)
        attributes.each do |attribute|
          define_method(attribute) { instance_variable_get("@attributes")[attribute] }
        end
      end

      def initialize(attributes)
        @attributes = deep_snake_case(attributes)
      end

      def method_name(key)
        key.gsub(/(.)([A-Z])/,'\1_\2').downcase
      end

      def deep_snake_case(object)
        if object.is_a?(Hash)
          object.map do |key, value|
            [method_name(key), deep_snake_case(value)]
          end.to_h
        elsif object.is_a?(Array)
          object.map do |value|
            deep_snake_case(value)
          end
        else
          object
        end
      end

      attr_reader :attributes
    end
  end
end
