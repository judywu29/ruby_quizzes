class BracketPacking

  Brackets = {"("=>")", "{"=>"}", "["=>"]"}
  #Brackets checking
  def valid? str
    loop do
      case str
      when /(\{B\}|\[B\]|\(B\)|BB)/
        str.gsub!($1, "B")
        return true if str == "B"
      else 
        return false
      end
    end
  end

  #interface to call to fix the string
  def fixing(str)
    reverse_str(fixing_closings(reverse_str(fixing_closings(str))))
  end

  private
  
  # add missing close brackets
  def fixing_closings(str)
    fixed = ""
    stack = []
    str.split("").each do |i|
      if Brackets.has_key?(i)
        stack.push(Brackets[i])
      elsif Brackets.has_value?(i)
        c = stack.pop
        # Append any missing closing brackets
        while c && c != i
          fixed << c
          c = stack.pop
        end
      end
      fixed << i
    end
    
    stack.reverse.each {|i| fixed << i}
    fixed
  end
  
  #reverse the string from [foo} => {foo]
  def reverse_str(str)
    reversed = ""
    str.split("").each do |i|
      if Brackets.has_key?(i)
        reversed << Brackets[i]
      elsif Brackets.has_value?(i)
        reversed << Brackets.invert[i]
      else reversed << i
      end
    end
    reversed.reverse
  end
  
end

if $0 == __FILE__
  if ARGV.length < 1
    puts "Usage: #$0 input string"
    exit(1)
  end
  
  str = ARGV.first
  bp = BracketPacking.new
  p bp.fixing(str)# unless bp.valid?(str.dup)
end
