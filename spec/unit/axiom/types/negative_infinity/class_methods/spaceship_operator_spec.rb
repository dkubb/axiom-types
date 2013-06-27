require 'spec_helper'

describe Axiom::Types::NegativeInfinity, '.<=>' do
  subject { object <=> other }

  let(:object) { described_class }

  context 'when the other object is a number' do
    let(:other) { 1 }

    it { should be(-1) }

    it 'is symmetric' do
      should be(-(other <=> object))
    end
  end

  context 'when the other object is infinity' do
    let(:other) { Axiom::Types::Infinity }

    it { should be(-1) }

    it 'is symmetric' do
      should be(-(other <=> object))
    end
  end

  context 'when the other object is negative infinity' do
    let(:other) { object }

    it { should be(0) }

    it 'is symmetric' do
      should be(-(other <=> object))
    end
  end

  context 'when the other object is -Float::INFINITY' do
    let(:other) { -Float::INFINITY }

    it { should be(0) }

    it 'is symmetric' do
      should be(-(other <=> object))
    end
  end

  context 'when the other object is not comparable' do
    let(:other) { 'string' }

    it { should be_nil }

    it 'is symmetric' do
      should be(other <=> object)
    end
  end
end
