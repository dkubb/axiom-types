# encoding: utf-8

module Axiom
  module Types

    # Represents an object type
    class Object < Type
      accept_options  :primitive, :coercion_method
      primitive       ::Object.superclass || ::Object
      coercion_method :to_object

      # Finalize by setting up a primitive constraint
      #
      # @return [Axiom::Types::Object]
      #
      # @api private
      def self.finalize
        return self if frozen?
        inherits_from_primitive
        super
      end

      # Add a constraint for the primitive
      #
      # @return [undefined]
      #
      # @api private
      def self.inherits_from_primitive
        constraint(&primitive.method(:===))
      end

      private_class_method :inherits_from_primitive

    end # class Object
  end # module Types
end # module Axiom
