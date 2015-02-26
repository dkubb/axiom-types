# encoding: utf-8

require 'spec_helper'

describe Axiom::Types::Float, '.finalize' do
  subject { Axiom::Types::Float.finalize }

  [
    -Float::MAX,
    0.0,
    Float::MAX,
  ].each do |value|
    it "adds a constraint that returns true for #{value}" do
      should include(value)
    end
  end
end
