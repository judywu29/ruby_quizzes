class Integer
  def weird?
    #weird number cannot be odd number: 
    return false unless self % 2 == 0
    divisors = get_divisors
    
    #make sure the number is abundant:
    return false if divisors.inject(:+) <= self * 2
    
    #to check if it's not semi-perfect(sum of some of the divisors equals to self)
    to_search = divisors.reverse
    return false if sum_in_subset? to_search.shift
    return true
      
  end
  
  def get_divisors
    div = [1]
    # 2.upto(Math.sqrt(self).floor) do |i|
      # if self % i == 0
        # div << i
      # end
    # end
    # div.reverse.each do |j|
      # div << self / j
    # end
    2.upto(self) do |i|
      div << i if self % i == 0
    end
    div.uniq
  end
  
  def sum_in_subset? arr
    return false if self < 0
    return true if arr.include? self
    return false if arr.length == 1
    first = arr.first
    remaining = arr[1..-1]
    #check the first number first and then the sum of the remaining numbers
    #and and the second number
    (self - first).sum_in_subset?(remaining) || sum_in_subset?(remaining)
  end
end


if $0 == __FILE__
  if ARGV.length < 1
    puts "Usage: #$0 <upper limit>"
    exit(1)
  end
  
  puts "Weird numbers up to and including #{ARGV[0]}:"
  start = Time.now
  
  limit = ARGV[0].to_i
  i = 69
  (i+1).upto(limit).each do |num|
    if num.weird?
      puts num
    end
  end
  puts "This took #{Time.now - start} seconds"
end