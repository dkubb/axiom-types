require 'spec_helper'

describe Axiom::Types, '.finalize' do
  subject { object.finalize }

  let(:object)      { described_class                   }
  let(:descendants) { [ descendant ]                    }
  let(:descendant)  { mock('descendant').as_null_object }

  before do
    object::Type.should_receive(:descendants).and_return(descendants)
  end

  it_should_behave_like 'a command method'

  it 'finalizes the descendants' do
    descendant.should_receive(:finalize)
    subject
  end
end
