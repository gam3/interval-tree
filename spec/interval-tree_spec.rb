# encoding: utf-8

require 'minitest/spec'
require 'minitest/autorun'

require 'interval-tree'

describe "IntervalTree::Node" do
  describe '.new' do
    describe 'given ([], [], [], [])' do
      it 'returns a Node object' do
        IntervalTree::Node.new([], [], [], []).must_be_instance_of(IntervalTree::Node)
      end
    end
  end
end

describe "IntervalTree::ExclusiveTree" do
  describe '#center' do
    describe 'given [(1...5),]' do
      it 'returns 1' do
        itvs = [(1...5),]
        t = IntervalTree::ExclusiveTree.new([])
        t.__send__(:center, itvs).must_equal 1
      end
    end
  end
end

describe "IntervalTree::InclusiveTree" do
  describe '#center' do
    describe 'given [(1..4),]' do
      it 'returns 1' do
        itvs = [(1..4),]
        t = IntervalTree::ExclusiveTree.new([])
        t.__send__(:center, itvs).must_equal 1
      end
    end
  end
end

