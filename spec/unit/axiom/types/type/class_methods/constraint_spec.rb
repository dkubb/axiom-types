require 'spec_helper'

describe Axiom::Types::Type, '.constraint' do
  let(:object) { Class.new(described_class) }

  context 'with no arguments or block' do
    subject { object.constraint }

    it { should respond_to(:call) }
    it { should be(Tautology)     }
  end

  context 'with a callable object' do
    subject { object.constraint(Contradiction) }

    it { should be(object) }

    its(:constraint) { should respond_to(:call) }
    its(:constraint) { should_not be(Tautology) }
  end

  context 'with a block' do
    subject { object.constraint { false } }

    it { should be(object) }

    its(:constraint) { should respond_to(:call) }
    its(:constraint) { should_not be(Tautology) }
  end
end
