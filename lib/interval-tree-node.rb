
module IntervalTree

  class Node
    def initialize(x_center, s_center, left_node, right_node)
      @x_center = x_center
      @s_center = s_center.sort_by(&:first)
      @s_max = s_center.map(&:last).max
      @left_node = left_node
      @right_node = right_node
    end
    attr_reader :x_center, :s_center, :s_max, :left_node, :right_node   
  end # class Node
  
end # module IntervalTree
