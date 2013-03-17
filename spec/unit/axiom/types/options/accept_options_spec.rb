# encoding: utf-8

require 'spec_helper'

describe Axiom::Types::Options, '#accept_options' do
  subject { object.accept_options(*new_options) }

  let(:object) do
    Class.new do
      extend Options, DescendantsTracker
    end
  end

  let(:child) do
    Class.new(object)
  end

  context 'with valid options' do
    let(:new_options) { [ :primitive, :coerce_method ] }

    it_should_behave_like 'a command method'
    it_should_behave_like 'an idempotent method'

    it 'adds methods to the object' do
      expect(object.public_methods(false)).to_not include(*new_options)
      subject
      expect(object.public_methods(false)).to include(*new_options)
    end

    it 'adds methods to the object that can set a value' do
      subject
      object.primitive(::String)
      expect(object.primitive).to be(::String)
    end

    context 'with the child class' do
      def force_inherit_from_object
        child
      end

      it 'is idempotent when called on the child' do
        subject
        force_inherit_from_object
        expect(child.accept_options(*new_options)).to be(child)
      end

      it 'adds the method to the descendants' do
        force_inherit_from_object
        expect(child.public_methods(false)).to_not include(*new_options)
        subject
        expect(child.public_methods(false)).to include(*new_options)
      end

      context 'when inherited' do
        before do
          object.accept_options(:opt)
          expect(object.opt(:default)).to be(object)
          force_inherit_from_object
        end

        it 'sets the descendant defaults' do
          expect(child.opt).to be(:default)
        end

        it 'adds methods to the descendant that can set a value' do
          child.opt(:value)
          expect(child.opt).to be(:value)
        end
      end

      context 'after inherited' do
        before do
          force_inherit_from_object
          object.accept_options(:opt)
          expect(object.opt(:default)).to be(object)
        end

        it 'does not set the descendant defaults' do
          expect(child.opt).to be_nil
        end

        it 'adds methods to the descendant that can set a value' do
          child.opt(:value)
          expect(child.opt).to be(:value)
        end
      end
    end
  end

  context 'with an option that conflicts with an existing method' do
    let(:new_options) { [ :name ] }

    specify do
      expect { subject }.to raise_error(
        Axiom::Types::Options::ReservedMethodError,
        'method named `:name` is already defined'
      )
    end
  end
end
