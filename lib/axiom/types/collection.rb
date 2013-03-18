# encoding: utf-8

module Axiom
  module Types

    # Represents a collection type
    class Collection < Object
      primitive      ::Enumerable
      accept_options :member_type

      member_type Object

      # Finalize by setting up constraints for the member
      #
      # @return [Class<Axiom::Types::Collection>]
      #
      # @api private
      def self.finalize
        return self if frozen?
        member_type.finalize
        matches_member_type
        super
      end

      # Add a constraints for the member
      #
      # @return [undefined]
      #
      # @api private
      def self.matches_member_type
        constraint do |object|
          object.all? { |member| member_type.include?(member) }
        end
      end

      private_class_method :matches_member_type

    end # class Collection
  end # module Types
end # module Axiom
