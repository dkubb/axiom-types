# encoding: utf-8

module Axiom
  module Types

    # Represents a boolean type
    class Boolean < Object
      coercion_method :to_boolean

      includes true, false

      # Infer the type if the primitive class matches
      #
      # @param [Object] object
      #
      # @return [Class<Axiom::Types::Boolean>]
      #   returned if the primitive class matches
      # @return [nil]
      #   returned if the primitive class does not match
      #
      # @api private
      def self.infer_from_primitive_class(object)
        self if TrueClass.singleton_class  === object ||
                FalseClass.singleton_class === object
      end

      private_class_method :infer_from_primitive_class

    end # class Boolean
  end # module Types
end # module Axiom
