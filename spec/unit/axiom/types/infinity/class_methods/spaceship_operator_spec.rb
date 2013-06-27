require 'spec_helper'

describe Axiom::Types::Infinity, '.<=>' do
  subject { described_class <=> other }

  context 'when the other object is a number' do
    let(:other) { 1 }

    it { should be(1) }
  end

  context 'when the other object is infinity' do
    let(:other) { described_class }

    it { should be(0) }
  end
end
