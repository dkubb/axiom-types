# encoding: utf-8

module Axiom
  module Types

    # Represents a decimal type
    class Hash < Numeric
      primitive       ::Hash
      coercion_method :to_hash
      accept_options  :key_type, :value_type

      key_type   ::Object
      value_type ::Object

      # TODO: create a factory method that returns a subtype with more
      # constrainted key/value types.

      def self.finalize
        return self if finalized?
        # TODO: lookup the types that handle the key/value primitives and then
        # setup a constraint for the keys and values.
        super
      end

    end # class Hash
  end # module Types
end # module Axiom
