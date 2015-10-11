require 'set'

class PenAndPaperGame
  
  #there are about 8 possible jumps we can take each time, from 
  #horizontally or vertically(3 squares) or diagonally (2 squares)
  Jumps = [
    [3, 0],
    [-3, 0],
    [0, 3],
    [0, -3],
    [2, 2],
    [2, -2],
    [-2, 2],
    [-2, -2]
  ]
  
  attr_reader :grid_size, :all_paths
  def initialize(input = { size: 5 })
    @grid_size = input[:size]
    @all_paths = Set.new
  end
  
  def solve
     x, y = rand(@grid_size), rand(@grid_size)
     @all_paths = [[x, y]]
     solve_it [[[x, y]]]

  end
  
  private
  def solve_it paths
    new_paths = []
    paths.each do |p|
      path = p.last
      p path
      return p if p.size == @grid_size*@grid_size
      jump(*path) do |new_path|
        unless p.include?(new_path)
          p new_path
          # @all_paths << new_path
          new_paths << (p.dup << new_path.dup) # has to be dup, change new_paths, also change @all_paths
          p new_paths
          # p @all_paths
          solve_it new_paths
        end
      end
      
    end  

  end
  
  def valid_position?(*position)
    (0...@grid_size).include?(position.first) && (0...@grid_size).include?(position.last)
  end
  
  def jump *origin_position
    Jumps.each do |move|
      new_move = move.zip(origin_position).map { |x, y| x + y }
      yield new_move if valid_position? *new_move
    end
  end
  
  def set_start_point x, y
    @all_paths = [[x, y]]
  end
  
end








