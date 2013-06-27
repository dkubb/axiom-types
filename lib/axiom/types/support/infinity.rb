# encoding: utf-8

module Axiom
  module Types

    # Represent an infinite number
    class Infinity

      # Test the number against infinity
      #
      # @param [Numeric, Infinity] other
      #
      # @return [0]
      #   returned if the other object is infinity
      # @return [1]
      #   returned if the other object is something other than infinity
      #
      # @api private
      def self.<=>(other)
        equal?(other) ? 0 : 1
      end

      # Return the next successive object, which is always self
      #
      # @return [Class<Infinity>]
      #
      # @api private
      def self.succ
        self
      end

    end # class Infinity

    # Represent a negative infinite number
    class NegativeInfinity < Infinity

      # Test the number against negative infinity
      #
      # @param [Numeric, Infinity] _other
      #
      # @return [0]
      #   returned if the other object is negative infinity
      # @return [-1]
      #   returned if the other object is something other than negative infinity
      #
      # @api private
      def self.<=>(_other)
        -super
      end

    end # class NegativeInfinity
  end # module Types
end # module Axiom
