class Integer
  
  def to_roman()
    tmp = self
    result = ""
    roman_mapping.keys.each do |divisor|
      times, tmp = tmp.divmod(divisor)
      result << roman_mapping[divisor]*times
    end 
    result
  end
  
  private
  def roman_mapping
    {
      1000 => "M",
      900 => "CM", #speical
      500 => "D",
      400 => "CD", #special
      100 => "C",
      90 => "XC",
      50 => "L",
      40 => "XL",
      10 => "X",
      9 => "IX",#special
      5 => "V",
      4 => "IV", #special
      1 => "I"
    }
  end
end