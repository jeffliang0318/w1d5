require_relative 'skeleton/lib/00_tree_node'
require 'byebug'
class KnightPathFinder
  DELTAS = [
    [2, 1],
    [1, 2],
    [2, -1],
    [1, -2],
    [-2, 1],
    [-1, 2],
    [-2, -1],
    [-1, -2]
  ]

  def self.valid_moves(pos)
    valid_moves = []

    DELTAS.each do |move|
      x = pos[0] + move[0]
      y = pos[1] + move[1]
      next if (x < 0 || y < 0) || (x > 7 || y > 7)
      valid_moves << [x,y]
    end

    valid_moves
  end

  def initialize(start_pos = [0, 0])
    @visited_positions = [start_pos]
    @start_pos = start_pos
  end

  def new_move_positions(pos)
    valid_moves = self.class.valid_moves(pos)
    new_moves = valid_moves - @visited_positions
    @visited_positions << new_moves

    new_moves
  end

  def build_move_tree(target_pos)
    queue = Queue.new

    new_moves = new_move_positions(@start_pos)
    new_moves_nodes = new_moves.map { |move| PolyTreeNode.new(move) }
    parent_node = PolyTreeNode.new(@start_pos)

    new_moves_nodes.each do |move_node|
      parent_node.add_child(move_node)
    end

    queue << parent_node

    until queue.empty?
      curr_pos = queue.pop
      return curr_pos if curr_pos.value == target_pos

      curr_pos.children.each do |child|
        queue << child
      end
    end

    nil
  end
end

path = KnightPathFinder.new
p path.build_move_tree([3,3])
