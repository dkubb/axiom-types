require 'spec_helper'

describe Axiom::Types::Type, '.finalize' do
  subject { object.finalize }

  let(:object) { Class.new(described_class) }

  it_should_behave_like 'a command method'

  it { should be_frozen }

  its(:constraint) { should be_frozen }
end
