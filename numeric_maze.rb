require 'set'

class NumMazer
  
  attr_reader :paths, :upper_bound, :start, :target
  def initialize(start, finish)
    #define a set to store all of the paths
    @paths = Set.new

    @start, @target = start.to_i, finish.to_i
    
    #set the upper and lower bounds to prevent going too far away from the target
    # @upper_bound =
    # if start < finish
      # (finish << 1) + 4
    # else (start << 1) + 4
    # end


  end

  def solve
    find_path([[@start]])
  end

  #find the path to include the target
  def find_path start_arr
    new_path = []
    start_arr.each do |arr|
      num = arr.last #everytime to take the last one to execute the 3 operations
      # next if num > @upper_bound
      return arr if num == @target

      #execute 3 operations on each number
      double_value = num << 1
      havle_value = num >> 1 unless (num & 1 == 1)
      add_value = num + 2

      (new_path << (arr.dup << double_value)) && (@paths.add(double_value)) unless @paths.include?(double_value)
      
      if havle_value
        unless @paths.include?(havle_value)
          new_path << (arr.dup << havle_value)
          @paths.add(havle_value)
        end
      end
      
      (new_path << (arr.dup << add_value)) && (@paths.add(add_value)) unless @paths.include?(add_value)

    end
    #try new path
    find_path(new_path)

  end
end

if $0 == __FILE__
  p NumMazer.new(ARGV[0], ARGV[1]).solve
end