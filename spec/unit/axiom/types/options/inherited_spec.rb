require 'spec_helper'

describe Axiom::Types::Options, '#inherited' do
  subject { descendant }

  let(:object) do
    Class.new(ancestor) do
      extend Options, DescendantsTracker
      accept_options :opt
      opt :default
    end
  end

  let(:ancestor) do
    Class.new
  end

  let(:descendant) do
    Class.new(object)
  end

  it 'delegates to the ancestor' do
    ancestor.should_receive(:inherited).twice
    subject
  end

  it 'adds the accepted option to the descendant' do
    subject
    expect(descendant.public_methods(false)).to include(:opt)
  end

  it 'sets the default value for the descendant' do
    subject
    expect(descendant.opt).to be(:default)
  end
end
