require 'spec_helper'

describe Axiom::Types::Type, '.new' do
  subject { object.new }

  context 'when called directly' do
    let(:object) { described_class }

    specify do
      expect { subject }.to raise_error(
        NotImplementedError, 'Axiom::Types::Type should not be instantiated'
      )
    end
  end

  context 'when called on a descendant' do
    let(:object) { Class.new(described_class) }

    specify do
      expect { subject }.to raise_error(
        NotImplementedError, "#{object.inspect} should not be instantiated"
      )
    end
  end
end
