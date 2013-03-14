# encoding: utf-8

module Axiom
  module Types

    # Abstract base class for every type
    class Type
      extend Options, DescendantsTracker

      accept_options :constraint
      constraint proc { true }

      # Instantiate a new Axiom::Types::Type subclass
      #
      # @example
      #   type = Axiom::Types::Type.new  # => Axiom::Types::Type
      #
      # @param [#call] constraint
      #   optional constraint for the new type
      #
      # @yield [object]
      #
      # @yieldparam object [Object]
      #   test if the object matches the type constraint
      #
      # @yieldreturn [Boolean]
      #   true if the object matches the type constraint
      #
      # @return [Class<Axiom::Types::Type>]
      #
      # @api public
      def self.new(constraint = Undefined, &block)
        type = ::Class.new(self, &block)
        type.constraint(constraint)
        type.finalize
      end

      # Finalize by deep freezing the type
      #
      # @return [Axiom::Types::Type]
      #
      # @api private
      def self.finalize
        IceNine.deep_freeze(self)
      end

      # Test if the object matches the type constraint
      #
      # @param [Object] object
      #
      # @return [Boolean]
      #
      # @api public
      def self.include?(object)
        included = @constraint.call(object)
        if included != true && included != false
          raise TypeError,
            "constraint must return true or false, but was #{included.inspect}"
        end
        included
      end

      # Add a constraint to the type
      #
      # @param [#call] constraint
      #   optional constraint
      #
      # @yield [object]
      #
      # @yieldparam object [Object]
      #   test if the object matches the type constraint
      #
      # @yieldreturn [Boolean]
      #   true if the object matches the type constraint
      #
      # @return [self]
      #
      # @api public
      def self.constraint(constraint = Undefined, &block)
        constraint = block if constraint.equal?(Undefined)
        return @constraint if constraint.nil?
        add_constraint(constraint)
        self
      end

      # Add a constraint that the object must be included in a set
      #
      # @param [Array<Object>] members
      #
      # @todo move into a module
      #
      # @api private
      def self.includes(*members)
        set = IceNine.deep_freeze(members.to_set)
        constraint(&set.method(:include?))
      end

      # Add new constraint to existing constraint, if any
      #
      # @param [#call] constraint
      #
      # @return [undefined]
      #
      # @api private
      def self.add_constraint(constraint)
        current     = @constraint
        @constraint = if current
          lambda { |object| constraint.call(object) && current.call(object) }
        else
          constraint
        end
      end

      private_class_method :includes, :add_constraint

    end # class Type
  end # module Types
end # module Axiom
