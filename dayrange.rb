require 'abbrev'

class DayRange
  
  attr_reader :days
  
  Week = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
  
  #get the num and abbrev hash with num as the key
  def self.create_abbrev_num_hash(abbrev_length = 3)
    @day_abbrev_hash = {}

    Week.abbrev.each do |abbrev, day|
      num = Week.index(day) + 1
      if abbrev.length == abbrev_length
        @day_abbrev_hash[num] = abbrev
      end
    end 
      
  end
  
  create_abbrev_num_hash
  
  #get the instance variable of the class
  def day_nums
    self.class.instance_variable_get("@day_abbrev_hash")
  end
  
  def initialize(days)
    abbrevs = day_nums.values
    # p days
    # p abbrevs
    @days = []
    days.each do |day|
      case day
      when *Week
        @days << Week.index(day) + 1
      when /[1-7]/
        @days << day.to_i
      when *abbrevs
        @days << day_nums.invert[day]
      else
        raise ArgumentError
      end     
    end
    @days.sort!
  end
  
    
  def to_s
    ranges = []
    num_ranges.each do |range|
      #separate elem
      if range.last == range.first
        ranges << day_nums[range.first]
      else
        values = day_nums.values_at(*range)
        #sequential
        if range.last >= range.first + 2
          ranges << values.join("-")
        else ranges << values.join(",")
        end
      end
 
    end
    ranges.join(",")
  end
  
  private
  def num_ranges
    @days.inject([]) do |arr, day|
      if arr.last && arr.last.last + 1 == day
        arr[-1][-1] = day
      else arr << [day, day]
      end
      arr
    end 
 
  end
  
end


if $0 == __FILE__
  if ARGV.length < 1
    puts "Usage: #$0 <Week Days>"
    exit(1)
  end
  p ARGV
  p DayRange.new(ARGV).to_s
  
end





