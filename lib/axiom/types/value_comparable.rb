# encoding: utf-8

module Axiom
  module Types

    # Add a minimum and maximum constraint to a type
    module ValueComparable

      def self.extended(descendant)
        descendant.accept_options :minimum, :maximum
      end

      def value_between(minium, maximum)
        constraint do |object|
          object.respond_to?(:between?) && object.between?(minium, maximum)
        end
      end

      def finalize
        return self if finalized?
        value_between(minimum, maximum)
        super
      end

    end # module ValueComparable
  end # module Types
end # module Axiom
