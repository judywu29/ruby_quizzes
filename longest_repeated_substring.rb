class String
  
  def longest_repeated_substring
    size = self.size
    
    #collect all of the suffixes of a string
    suffixes = []
    size.times do |i|
      suffixes << self[i..-1]
    end
    suffixes.sort!
    # p suffixes
    
    #the longest length of repeated substring
    best_at_least = 1
    #the repeated substring with longest length
    longest_match = ""
    
    (1..size-2).each do |i|
      (i..size-1).each do |j|
        s1 = suffixes[i]
        s2 = suffixes[j]
        distance = (s1.size - s2.size).abs
          best = longest_common_prefix(s1, s2, distance)
          #exchange the length and substring if current one is longer
          if best.size > best_at_least
            longest_match = best
            best_at_least = best.size
          end
      end
    end
    longest_match
  
  end

  private
  #the common part cannot be longer than their distance, orelse it's overlapped
  def longest_common_prefix(s1, s2, distance)
    min = [s1.size, s2.size, distance].min
    min.times do |x|
      return s1[0...x] if s1[x] != s2[x]
    end
    return s1[0...min]
  end
end
