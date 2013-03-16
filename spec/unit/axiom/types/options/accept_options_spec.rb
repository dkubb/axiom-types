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

  let(:grand_child) do
    Class.new(child)
  end

  context 'with valid options' do
    let(:new_options) { [ :primitive, :coerce_method ] }

    it_should_behave_like 'a command method'
#    it_should_behave_like 'an idempotent method'

    it 'adds methods to the object' do
      expect(object.public_methods).to_not include(*new_options)
      subject
      expect(object.public_methods).to include(*new_options)
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

      it 'adds the method to the descendants' do
        force_inherit_from_object
        expect(child.public_methods).to_not include(*new_options)
        subject
        expect(child.public_methods).to include(*new_options)
      end

      it 'adds methods to the descendant, when inherited, that can set a value' do
        subject
        force_inherit_from_object
        child.primitive(::String)
        expect(child.primitive).to be(::String)
      end

      it 'adds methods to the descendant, after inherited, that can set a value' do
        subject
        force_inherit_from_object
        object.accept_options(:opt)
        child.opt(:value)
        expect(child.opt).to be(:value)
      end

      it 'sets the descendant defaults' do
        subject
        object.primitive(::String)
        force_inherit_from_object
        expect(child.primitive).to be(::String)
      end
    end

    context "with the descendant's descendant" do
      def force_inherit_from_child
        grand_child
      end

      it 'adds the method to the descendants' do
        force_inherit_from_child
        expect(grand_child.public_methods).to_not include(*new_options)
        subject
        expect(grand_child.public_methods).to include(*new_options)
      end

      it 'adds methods to the descendant, when inherited, that can set a value' do
        subject
        force_inherit_from_child
        grand_child.primitive(::String)
        expect(grand_child.primitive).to be(::String)
      end

      it 'adds methods to the descendant from the object, after inherited, that can set a value' do
        subject
        force_inherit_from_child
        object.accept_options(:opt)
        grand_child.opt(:value)
        expect(grand_child.opt).to be(:value)
      end

      it 'adds methods to the descendant from the child, after inherited, that can set a value' do
        subject
        force_inherit_from_child
        child.accept_options(:opt)
        grand_child.opt(:value)
        expect(grand_child.opt).to be(:value)
      end

      it 'sets the descendant defaults from the object' do
        subject
        object.primitive(::String)
        force_inherit_from_child
        expect(grand_child.primitive).to be(::String)
      end

      it 'sets the descendant defaults from the child' do
        subject
        child.primitive(::String)
        force_inherit_from_child
        expect(grand_child.primitive).to be(::String)
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
