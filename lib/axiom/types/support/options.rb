module Axiom
  module Types

    # A module that adds class and instance level options
    module Options

      # Returns default options hash for a given attribute class
      #
      # @example
      #   Axiom::Types::String.options
      #   # => {:primitive => String}
      #
      # @return [Hash]
      #   a hash of default option values
      #
      # @api public
      def options
        accepted_options.each_with_object({}) do |option_name, options|
          option_value         = public_send(option_name)
          options[option_name] = option_value unless option_value.nil?
        end
      end

      # Returns an array of valid options
      #
      # @example
      #   Axiom::Types::String.accepted_options
      #   # => [:primitive, :accessor, :reader, :writer]
      #
      # @return [Array]
      #   the array of valid option names
      #
      # @api public
      def accepted_options
        @accepted_options ||= []
      end

      # Defines which options are valid for a given attribute class
      #
      # @example
      #   class MyTypes < Axiom::Types::Object
      #     accept_options :foo, :bar
      #   end
      #
      # @return [self]
      #
      # @api public
      def accept_options(*new_options)
        add_accepted_options(new_options)
        new_options.each { |option| define_option_method(option) }
        descendants.each { |descendant| descendant.add_accepted_options(new_options) }
        self
      end

    protected

      # Adds a reader/writer method for the give option name
      #
      # @return [undefined]
      #
      # @api private
      def define_option_method(option)
        ivar = "@#{option}"
        singleton_class.class_eval do
          define_method(option) do |*args|
            return instance_variable_get(ivar) if args.empty?
            instance_variable_set(ivar, *args)
            self
          end
        end
      end

      # Sets default options
      #
      # @param [#each] new_options
      #   options to be set
      #
      # @return [self]
      #
      # @api private
      def set_options(new_options)
        new_options.each { |pair| public_send(*pair) }
        self
      end

      # Adds new options that an attribute class can accept
      #
      # @param [#to_ary] new_options
      #   new options to be added
      #
      # @return [self]
      #
      # @api private
      def add_accepted_options(new_options)
        accepted_options.concat(new_options)
        self
      end

    private

      # Adds descendant to descendants array and inherits default options
      #
      # @param [Class] descendant
      #
      # @return [undefined]
      #
      # @api private
      def inherited(descendant)
        super
        descendant.add_accepted_options(accepted_options).set_options(options)
      end

    end # module Options
  end # module Types
end # module Axiom
