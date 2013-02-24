# encoding: utf-8

module Axiom
  module Types

    # Represents a decimal type
    class Hash < Numeric
      primitive       ::Hash
      coercion_method :to_hash
      accept_options  :key_type, :value_type

      key_type   Object
      value_type Object

      # TODO: create a factory method that returns a subtype with more
      # constrainted key/value types. This should be used with the lookup
      # system so that the best matching type can be used. It could also check
      # the descendants to see if a previously created type matches the key and
      # value types, in which case it can be reused.

      def self.finalize
        return self if finalized?
        matches(key_type, value_type)
        super
      end

      def self.matches(key_type, value_type)
        constraint do |hash|
          # TODO: change to #to_h when added to backports
          hash.respond_to?(:to_hash) && hash.to_hash.all? do |key, value|
            key_type.include?(key) && value_type.include?(value)
          end
        end
      end

      private_class_method :matches

    end # class Hash
  end # module Types
end # module Axiom
