# encoding: utf-8

require 'minitest/spec'
require 'minitest/autorun'

require 'inclusive_interval_tree'

describe "InclusiveIntervalTree::Node" do

  describe '.new' do
    describe 'given ([], [], [], [])' do
      it 'returns a Node object' do
        InclusiveIntervalTree::Node.new([], [], [], []).must_be_instance_of(InclusiveIntervalTree::Node)
      end
    end
  end
 
end

describe "InclusiveIntervalTree::Tree" do

  describe '#center' do
    describe 'given [(1..4),]' do
      it 'returns 1' do
        itvs = [(1..4),]
        t = InclusiveIntervalTree::Tree.new([])
        t.__send__(:center, itvs).must_equal 1

      end
    end

    describe 'given [(1..4), (2..5)]' do
      it 'returns 2' do
        itvs = [(1..4), (2..5),]
        t = InclusiveIntervalTree::Tree.new([])
        t.__send__(:center, itvs).must_equal 2
      end
    end
  end

  describe '.new' do
     describe 'given [(1..4),]' do
       it 'returns an Tree objects' do
         itvs = [(1..4),]
         InclusiveIntervalTree::Tree.new(itvs).must_be_instance_of InclusiveIntervalTree::Tree
      end
    end
  
    describe 'given [(1..4),(2..5), (3..6)]' do
      it 'returns ret.top_node.x_centeran == 2 ' do
        itvs = [(1..4),(2..5), (3..6)]
        tree = InclusiveIntervalTree::Tree.new(itvs)
        tree.top_node.x_center.must_equal 2
      end
    end
  end

  describe '#search' do
    describe 'given [(1..4)] a point query "3"' do
      it 'returns an array of intervals (1..4)]' do
        InclusiveIntervalTree::Tree.new([1..4]).search(3).must_equal [1..4]
      end
    end
    
    describe 'given non-array full-closed "(1..4)" and a point query "3"' do
      it 'returns an array contains a half-open interval (1...5)]' do
        skip
        InclusiveIntervalTree::Tree.new(1...5).search(3).must_equal [1..4]
      end
    end
    
    describe 'given [(1..4), (2..5)] and a point query "3"' do
      it 'returns [(1..4), (2..5)]' do
        itvs = [(1..4), (2..5),]
        results = InclusiveIntervalTree::Tree.new(itvs).search(3)
        results.must_equal itvs
      end
    end

    describe 'given [0..7, 1..4, 2..5] and a point query "3"' do
      it 'returns [0..7, 1..4, 2..5]' do
        itvs = [0..7, 1..4, 2..5]
        results = InclusiveIntervalTree::Tree.new(itvs).search(3)
        results.must_equal itvs
      end
    end

    describe 'given [(0..7), (1..4), (2..5)] and a query by (1...4)' do
      it 'returns [(0..7), (1..4), (2..5)]' do
        itvs = [(0..7), (1..4), (2..5)]
        results = InclusiveIntervalTree::Tree.new(itvs).search(1...4)
        results.must_equal itvs
      end
    end

    describe 'given [(1..2), (3..4)] and a query by 3' do
      it 'returns [(3..4)]' do
        results = InclusiveIntervalTree::Tree.new([(1..2), (3..4)]).search(3..8)
        results.must_equal [(3..4)]
      end
    end

    describe 'given [(1..3), (3..5), (4..8)] and a query by (3..5)' do
      it 'returns [(3..5), (4..8)]' do
        itvs = [(1..2), (3..4), (4..7)]
        results = InclusiveIntervalTree::Tree.new(itvs).search(3..5)
        results.must_equal [(3..4), (4..7)]
      end
    end

    describe 'given [(1..2), (3..4), (3..8), (4..8)] and a query by (3..4)' do
      it 'returns [(3..4), (3..8), (4..7)]' do
        itvs = [(1..2), (3..4), (3..8), (4..7)]
        results = InclusiveIntervalTree::Tree.new(itvs).search(3..5)
        results.must_equal [(3..4), (3..8), (4..7)]
      end
    end

    describe 'given [(1..1), (4..5), (7..7), (9..10), (3..8), (2..3), (4..4), (8..8), (6..6), (13..13)] and a query by (7..7)' do
      it 'returns [(7..7)]' do
        itvs = [(1..1), (4..5), (7..7), (9..10), (3..8), (2..3), (4..4), (8..8), (6..6), (13..13)]
        results = InclusiveIntervalTree::Tree.new(itvs).search(7..7)
        results.must_equal [(3..8), (7..7)]
      end
    end
    describe 'given [(1..1), (4..5), (7..7), (9..10), (3..8), (2..3), (4..4), (8..8), (6..6), (13..13)] and a query by (7..7)' do
      it 'returns [3..8, 7..7]' do
        itvs = [ 3..8, 7..7 ]
        results = InclusiveIntervalTree::Tree.new(itvs).search(7..7)
        results.must_equal [3..8, 7..7]
      end
    end
    describe 'given [(1..1), (4..5), (7..7), (9..10), (3..8), (2..3), (4..4), (8..8), (6..6), (13..13)] and a query by (3..8)' do
      it 'returns [ 2..3, 3..8, 4..4, 4..5, 6..6, 7..7, 8..8 ]' do
        itvs = [(1..1), (4..5), (7..7), (9..10), (3..8), (2..3), (4..4), (8..8), (6..6), (13..13)]
        results = InclusiveIntervalTree::Tree.new(itvs).search(3..8)
        results.must_equal [ 2..3, 3..8, 4..4, 4..5, 6..6, 7..7, 8..8 ]
      end
    end
  end

end

