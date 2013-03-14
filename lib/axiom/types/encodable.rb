# encoding: utf-8

module Axiom
  module Types

    # Add encoding constraints to a type
    module Encodable

      if RUBY_VERSION >= '1.9'
        def self.extended(descendant)
          descendant.accept_options :encoding
          descendant.encoding Encoding::UTF_8
        end

        def finalize
          return self if frozen?
          has_encoding(encoding)
          super
        end

      private

        def has_encoding(encoding)
          constraint do |object|
            object.encoding.equal?(encoding) ||
            (encoding.ascii_compatible? && object.to_s.ascii_only?)
          end
        end
      end

    end # module Encodable
  end # module Types
end # module Axiom
