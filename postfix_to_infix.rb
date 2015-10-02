
class String 
  
  #map all of the operators to its priorities: 
  Prec = {:+ => 0, :- => 0, :* => 1, :/ => 1, :% => 1}
  
  Operators = %w(+ - * / %)
  
  def postfix_to_infix()
    origin_arr = self.split(" ")
    
    final_arr = origin_arr.inject([]) do |arr, item|
      case item
      when *Operators
        
        current_prec = Prec[item.to_sym]
        righ_ele = arr.pop
        left_ele = arr.pop
        
        left_str = left_ele.first
        right_str = righ_ele.first
        
         #check if braces are needed
         left_str = "(" + left_str + ")" if left_ele.last < current_prec
         right_str = "(" + right_str + ")" if righ_ele.last < current_prec
        
        
        #push the fresh operation into the arr
        arr << [left_str + item + right_str, current_prec]
        
      when /\d+/
        arr << [item, 1] #add default priority for the digits
      end
      arr
    end
    
    final_arr.first.first
  end
  
end
  

# puts "Please type the postfix string here:"
# 
# command = $stdin.gets
# puts command.postfix_to_infix 
