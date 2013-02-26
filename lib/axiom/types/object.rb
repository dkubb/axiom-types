# encoding: utf-8

module Axiom
  module Types

    # Represents an object type
    class Object < Type
      accept_options  :primitive, :coercion_method
      primitive       ::Object.superclass || ::Object
      coercion_method :to_object

      def self.finalize
        return self if finalized?
        inherits_from(primitive)
        super
      end

      def self.inherits_from(primitive)
        constraint(&primitive.method(:===))
      end

      private_class_method :inherits_from

    end # class Object
  end # module Types
end # module Axiom
