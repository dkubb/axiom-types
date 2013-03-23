# encoding: utf-8

module Axiom
  module Types

    # Represents a boolean type
    class Boolean < Object
      coercion_method :to_boolean

      includes true, false

      # Test if the object is the correct primitive class
      #
      # @param [Object] object
      #
      # @return [Boolean]
      #
      # @api private
      def self.primitive_class?(object)
        TrueClass.singleton_class  === object ||
        FalseClass.singleton_class === object
      end

      private_class_method :primitive_class?

    end # class Boolean
  end # module Types
end # module Axiom
