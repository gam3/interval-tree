#!/usr/local/bin/ruby-1.9
# encoding: utf-8
#
# Title:: the InclusiveIntervalTree module using "augmented tree"
# Author:: MISHIMA, Hiroyuki ( https://github.com/misshie ), 2011
# Copyright:: The MIT/X11 license
#
# see also ....
#  description in Wikipedia
#    http://en.wikipedia.org/wiki/Interval_tree
#  implementstion in Python by Tyler Kahn 
#    http://forrst.com/posts/Interval_Tree_implementation_in_python-e0K    
#
# Usage:
#  require "interval_tree"
#  itv = [(0..2), (1..3), (3..4),]
#  t = InclusiveIntervalTree::Tree.new(itv)
#  p t.search(2) => [0..2, 1..3]
#  p t.search(1..3) => [0..2, 1..3, 3..4]
#
# note: result intervals are always returned
# in the "left-closed and right-closed" style that can be expressed
# by two-dotted Range object literals (first..last)
#

require 'interval-tree-node'

module IntervalTree
  class InclusiveTree
    def initialize(ranges)
      ranges_incl = ensure_inclusive_end([ranges].flatten)
      @top_node = divide_intervals(ranges_incl)
    end
    attr_reader :top_node

    def divide_intervals(intervals)
      return nil if intervals.empty?
      x_center = center(intervals)

      s_center = Array.new
      s_left = Array.new
      s_right = Array.new

      intervals.each do |k|
        case
        when k.last < x_center
          s_left << k
        when x_center < k.first
          s_right << k
        else
          s_center << k
        end
      end

      Node.new(x_center, s_center, divide_intervals(s_left), divide_intervals(s_right))
    end


    def search(interval)
      return [] unless self.top_node
      ret = nil
      if interval.respond_to?(:first)
        first = interval.first
        last = interval.last
      else
        first = interval
        last = nil
      end

      if last
        result = Array.new        
        (interval).each do |j|
          search(j).each{|k|result << k}
          result.uniq!
        end
        ret = result.sort_by{|x|[x.first, x.last]}
      else
        ret = point_search(self.top_node, first, []).sort_by{|x|[x.first, x.last]}
      end
      return ret
    end
    
    private

    def ensure_inclusive_end(ranges)
      ret = []
      ranges.each do |r|
        if r.exclude_end?
	  ret << Range.new(r.first, r.last-1)
	else
	  ret << r
	end
      end
      ret
    end
    
    # augmented tree
    # using a start point as resresentative value of the node
    def center(intervals)
      fs = intervals.sort_by{ |x| x.first}
      fs[fs.length/2].first
    end

    def point_search(node, point, result)
      raise "error" unless node;
      node.s_center.each do |k|
        result << k if (k.first <= point) && (point <= k.last) 
      end
      if point <= node.x_center && node.left_node
        point_search(node.left_node, point, []).each{ |k| result << k}
      end
      if point > node.x_center && node.right_node
        point_search(node.right_node, point, []).each{ |k| result << k}
      end
      result.uniq
    end
  end # class Tree
end # module IntervalTree

if  __FILE__ == $0
  puts "Inclusive Interval Tree Library"
end
