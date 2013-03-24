# encoding: utf-8

require 'spec_helper'

describe Axiom::Types::Options, '#inherited' do
  subject { descendant }

  let(:object) do
    Class.new(ancestor) do
      extend Options, DescendantsTracker
      accept_options :primitive, :coerce_method
      primitive ::String
    end
  end

  let(:ancestor) do
    Class.new
  end

  let(:descendant) do
    Class.new(object)
  end

  context 'when the option is not set' do
    it 'delegates to the ancestor' do
      ancestor.should_receive(:inherited).twice
      subject
    end

    it 'adds the accepted option to the descendant' do
      subject
      expect(descendant).to respond_to(:primitive, :coerce_method)
    end

    it 'sets the default value for the descendant' do
      subject
      expect(descendant.primitive).to be(::String)
    end
  end

  context 'when the option is set' do
    before do
      def ancestor.inherited(descendant)
        # set the option explicitly
        descendant.instance_variable_set(:@primitive, ::Integer)
      end
    end

    it 'delegates to the ancestor' do
      ancestor.should_receive(:inherited).twice
      subject
    end

    it 'adds the accepted option to the descendant' do
      subject
      expect(descendant).to respond_to(:primitive, :coerce_method)
    end

    it 'does not set the value for the descendant when not set' do
      subject
      expect(descendant.primitive).to be(::Integer)
    end
  end
end
