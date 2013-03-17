# encoding: utf-8

require 'spec_helper'

describe Axiom::Types::Encodable, '#finalize', :if => RUBY_VERSION >= '1.9' do
  subject { object.finalize }

  let(:object) { Class.new(Axiom::Types::Type).extend(described_class) }

  context 'when an ascii compatible encoding (UTF-8) is used' do
    it_should_behave_like 'a command method'
    it_should_behave_like 'an idempotent method'

    it { should be_frozen }

    its(:constraint) { should be_frozen }

    defined?(::Encoding) && Encoding.list.each do |encoding|
      if encoding.ascii_compatible?
        it "adds a constraint that returns true for #{encoding} encoding" do
          should include(''.force_encoding(encoding))
        end
      else
        it "adds a constraint that returns false for #{encoding} encoding" do
          should_not include(''.force_encoding(encoding))
        end
      end
    end
  end

  context 'when an non-ascii compatible encoding (UTF-16BE) is used' do
    before do
      object.encoding Encoding::UTF_16BE
    end

    it_should_behave_like 'a command method'
    it_should_behave_like 'an idempotent method'

    it { should be_frozen }

    its(:constraint) { should be_frozen }

    defined?(::Encoding) && Encoding.list.each do |encoding|
      if encoding.equal?(Encoding::UTF_16BE)
        it "adds a constraint that returns true for #{encoding} encoding" do
          should include(''.force_encoding(encoding))
        end
      else
        it "adds a constraint that returns false for #{encoding} encoding" do
          should_not include(''.force_encoding(encoding))
        end
      end
    end
  end
end
