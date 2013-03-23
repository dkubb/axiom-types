# encoding: utf-8

module Axiom
  module Types

    # Represents an object type
    class Object < Type
      accept_options  :primitive, :coercion_method
      primitive       ::Object.superclass || ::Object
      coercion_method :to_object

      # Infer the type of the object
      #
      # @example
      #   Axiom::Types::Object.infer(::Object)  # => Axiom::Types::Object
      #
      # @param [Object] object
      #
      # @return [Class<Axiom::Types::Object>]
      #   returned if the type matches
      # @return [nil]
      #   returned if the type does not match
      #
      # @api public
      def self.infer(object)
        super || (self if primitive_class?(object))
      end

      # Finalize by setting up a primitive constraint
      #
      # @return [Class<Axiom::Types::Object>]
      #
      # @api private
      def self.finalize
        return self if frozen?
        inherits_from_primitive
        super
      end

      # Test if the object is the correct primitive class
      #
      # @param [Object] object
      #
      # @return [Boolean]
      #
      # @api private
      def self.primitive_class?(object)
        primitive.singleton_class === object
      end

      # Add a constraint for the primitive
      #
      # @return [undefined]
      #
      # @api private
      def self.inherits_from_primitive
        constraint(&primitive.method(:===))
      end

      private_class_method :primitive_class?, :inherits_from_primitive

    end # class Object
  end # module Types
end # module Axiom
