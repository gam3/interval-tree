# encoding: utf-8

require 'spec/helper'

#require 'minitest/spec'
require 'minitest/autorun'

require 'exclusive-interval-tree'

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

    describe 'given [(1...5), (2...6)]' do
      it 'returns 2' do
        itvs = [(1...5), (2...6),]
        t = IntervalTree::ExclusiveTree.new([])
        t.__send__(:center, itvs).must_equal 2
      end
    end
  end

  describe '.new' do
     describe 'given [(1...5),]' do
       it 'returns an Tree objects' do
         itvs = [(1...5),]
         IntervalTree::ExclusiveTree.new(itvs).must_be_instance_of IntervalTree::ExclusiveTree
      end
    end
  
    describe 'given [(1...5),(2...6), (3...7)]' do
      it 'returns ret.top_node.x_centeran == 2 ' do
        itvs = [(1...5),(2...6), (3...7)]
        tree = IntervalTree::ExclusiveTree.new(itvs)
        tree.top_node.x_center.must_equal 2
      end
    end
  end

  describe '#search' do
    describe 'given [(1...5)] a point query "3"' do
      it 'returns an array of intervals (1...5)]' do
        IntervalTree::ExclusiveTree.new([1...5]).search(3).must_equal [1...5]
      end
    end
    
    describe 'given non-array full-closed "(1..4)" and a point query "3"' do
      it 'returns an array contains a half-open interval (1...5)]' do
        IntervalTree::ExclusiveTree.new(1..4).search(3).must_equal [1...5]
      end
    end
    
    describe 'given [(1...5), (2...6)] and a point query "3"' do
      it 'returns [(1...5), (2...6)]' do
        itvs = [(1...5), (2...6),]
        results = IntervalTree::ExclusiveTree.new(itvs).search(3)
        results.must_equal itvs
      end
    end

    describe 'given [(0...8), (1...5), (2...6)] and a point query "3"' do
      it 'returns [(0...8), (1...5), (2...6)]' do
        itvs = [(0...8), (1...5), (2...6)]
        results = IntervalTree::ExclusiveTree.new(itvs).search(3)
        results.must_equal itvs
      end
    end

    describe 'given [(0...8), (1...5), (2...6)] and a query by (1...4)' do
      it 'returns [(0...8), (1...5), (2...6)]' do
        itvs = [(0...8), (1...5), (2...6)]
        results = IntervalTree::ExclusiveTree.new(itvs).search(1...4)
        results.must_equal itvs
      end
    end

    describe 'given [(1...3), (3...5)] and a query by 3' do
      it 'returns [(3...9)]' do
        results = IntervalTree::ExclusiveTree.new([(1...3), (3...5)]).search(3...9)
        results.must_equal [(3...5)]
      end
    end

    describe 'given [(1...3), (3...5), (4...8)] and a query by (3...5)' do
      it 'returns [(3...5), (4...8)]' do
        itvs = [(1...3), (3...5), (4...8)]
        results = IntervalTree::ExclusiveTree.new(itvs).search(3...5)
        results.must_equal [(3...5), (4...8)]
      end
    end

    describe 'given [(1...3), (3...5), (3...9), (4...8)] and a query by (3...5)' do
      it 'returns [(3...5), (3...9), (4...8)]' do
        itvs = [(1...3), (3...5), (3...9), (4...8)]
        results = IntervalTree::ExclusiveTree.new(itvs).search(3...5)
        results.must_equal [(3...5), (3...9), (4...8)]
      end
    end

    describe 'given [(0...7), (3...5), (3...9), (4...8)] and a query by (3...5)' do
      it 'returns [(0...7), (3...5), (3...9), (4...8)]' do
        itvs = [(0...7), (1...3), (3...5), (3...9), (4...8)]
        results = IntervalTree::ExclusiveTree.new(itvs).search(3)
        results.must_equal [(0...7), (3...5), (3...9)]
      end
    end

  end

end

