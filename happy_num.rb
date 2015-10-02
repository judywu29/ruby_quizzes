class HappyNum
  
  Max = 100_000
  Unhappy = [0, 4, 16, 20, 37, 42, 58, 89, 145].freeze
  
  def initialize()
    @sum_of_digits = {}
  end

  #compare their ranks and get the highest rank
  def happiest_num max=Max
    max_rank = 1
    happiest_num = 1
    (1..max).each do |number|
      rank = rank_of_happiess number
      if rank > max_rank
        max_rank = rank
        happiest_num = number
      end
    end
    [happiest_num, max_rank]
  end
  
  private
  #get the rank of happies of each number
  def rank_of_happiess number
    i = 0
    num = number
    
    while true
      #Zero squared is still zero and adding zero has no effect, so we can safely strip those out of the digits.
      #order here: to skip several calculations: The numbers 123 and 321 both involve the same calculations
      digits = num.to_s.split("").sort.map{ |d| d.to_i }.delete_if{ |d| d == 0 }
      
      num = @sum_of_digits[digits] || digits.inject(0){ |sum, digit| sum += digit * digit; sum }
      # p num
      return 0 if Unhappy.include?(num)
  
      return i if num == 1
      
      i += 1
      @sum_of_digits[digits] = num unless @sum_of_digits.has_key? digits
    end
   end
   
end



