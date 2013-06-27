require 'spec_helper'

describe Axiom::Types::Infinity, '.succ' do
  subject { described_class.succ }

  it { should be(described_class) }
end
