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
        constraint { |object| primitive === object }
        super
      end

    end # class Object
  end # module Types
end # module Axiom
