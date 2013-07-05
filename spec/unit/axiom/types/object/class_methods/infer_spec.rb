# encoding: utf-8

require 'spec_helper'
require 'backports/basic_object' unless defined?(::BasicObject)

describe Axiom::Types::Object, '.infer' do
  subject { object.infer(arg) }

  let(:object) { described_class }

  context 'when the argument is the type object' do
    let(:arg) { object }

    it { should be(object) }
  end

  context 'when the argument is ::BasicObject' do
    let(:arg) { ::BasicObject }

    it { should be(object) }
  end

  context 'when the argument is ::Object' do
    let(:arg) { ::Object }

    it { should be(object) }
  end

  Axiom::Types::Object.descendants.each do |descendant|
    primitive = descendant.primitive

    context "when the argument is ::#{primitive}" do
      let(:arg) { primitive }

      if primitive.instance_of?(::Module)
        it 'does not match modules' do
          should be_nil
        end
      else
        it 'matches all classes' do
          should be(object)
        end
      end
    end
  end

  context 'when the argument is an object instance' do
    let(:arg) { ::Object.new }

    it { should be_nil }
  end

  context 'when the argument is nil' do
    let(:arg) { nil }

    it { should be_nil }
  end
end
