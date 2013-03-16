# encoding: utf-8

module Axiom
  module Types

    # Represents a hash type
    class Hash < Object
      primitive       ::Hash
      coercion_method :to_hash
      accept_options  :key_type, :value_type

      key_type   Object
      value_type Object

      # Finalize by setting up constraints for the key and value
      #
      # @return [Axiom::Types::Object]
      #
      # @api private
      def self.finalize
        return self if frozen?
        key_type.finalize
        value_type.finalize
        matches_key_and_value_types
        super
      end

      # Add a constraints for the key and value
      #
      # @return [undefined]
      #
      # @api private
      def self.matches_key_and_value_types
        constraint do |object|
          object.to_h.all? do |key, value|
            key_type.include?(key) && value_type.include?(value)
          end
        end
      end

      private_class_method :matches_key_and_value_types

    end # class Hash
  end # module Types
end # module Axiom
