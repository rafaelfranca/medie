require 'spec_helper'

describe Medie::Xml::Links do
  describe '#initialize' do
    context 'without arguments' do
      subject { Medie::Xml::Links.new }

      it 'has no links' do
        subject.size.should == 0
      end
    end

    context 'with nil argument' do
      subject { Medie::Xml::Links.new(nil) }

      it 'has no links' do
        subject.size.should == 0
      end
    end

    context 'with a hash as argument' do
      subject { Medie::Xml::Links.new({ 'rel' => 'test', 'href' => 'http://example.com/test', 'type' => 'application/xml'}) }

      it 'has one link' do
        subject.size.should == 1
      end
    end

    context 'with an array as argument' do
      context 'without items' do
        subject { Medie::Xml::Links.new([]) }

        it 'has no links' do
          subject.size.should == 0
        end
      end

      context 'with one item' do
        subject { Medie::Xml::Links.new([{ 'rel' => 'test', 'href' => 'http://example.com/test', 'type' => 'application/xml'}]) }

        it 'has one link' do
          subject.size.should == 1
        end
      end

      context 'with more than one item' do
        subject do
          Medie::Xml::Links.new([
            { 'rel' => 'test', 'href' => 'http://example.com/test', 'type' => 'application/xml'},
            { 'rel' => 'test2', 'href' => 'http://example.com/test2', 'type' => 'application/xml'}
          ])
        end

        it 'has the same size of the array' do
          subject.size.should == 2
        end
      end
    end
  end

  context 'try to access a link by rel' do
    context "that doesn't exist" do
      subject { Medie::Xml::Links.new }

      it 'return nil' do
        subject['test'].should_not be
      end
    end

    context 'that exist' do
      subject { Medie::Xml::Links.new([{ 'rel' => 'test', 'href' => 'http://example.com/test', 'type' => 'application/xml'}]) }

      it 'returns a link' do
        subject['test'].should be_kind_of(Medie::Link)
        subject['test'].href.should == 'http://example.com/test'
      end
    end
  end
end
