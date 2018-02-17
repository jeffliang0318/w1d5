class PolyTreeNode

  def initialize(value, parent = nil, children = [])
    @value = value
    @parent = parent
    @children = children
  end

  def parent=(node)
    @parent.children.delete(self) unless @parent == nil
    @parent = node
    node.add_child(self) unless @parent == nil || node.children.include?(self)
  end

  def add_child(node)
    node.parent=(self) unless node.parent == self
    self.children << node unless @children.include?(node)
  end

  def remove_child(node)
    raise "node is not a child" unless @children.include?(node)
    @children.delete(node)
    node.parent=(nil)
  end

  def dfs(target_value)
    return self if @value == target_value

    @children.each do |child|
      result = child.dfs(target_value)

      return result unless result == nil
    end

    nil
  end

  def bfs(target_value)
    queue = Queue.new

    queue << self # [1]
    until queue.empty?
      cur_node = queue.pop
      return cur_node if cur_node.value == target_value

      cur_node.children.each do |child|
        queue << child # [2,3]
      end
    end

    nil
  end

  attr_accessor :value, :parent, :children

end
