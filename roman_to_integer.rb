class String
  
  #To convert Roman Numberal to Integer
  def to_arabic_recursive(str = self, result = 0)
    return result if str.empty?
    roman_mapping.values.each do |roman|
      if str.start_with? roman
        result += roman_mapping.invert[roman] #from value to key
        str = str[roman.length..-1]
        return to_arabic_recursive(str, result)
      end
    end
  end
  
  private
  def roman_mapping
    {
      1000 => "M",
      900 => "CM",
      500 => "D",
      400 => "CD",
      100 => "C",
      90 => "XC",
      50 => "L",
      40 => "XL",
      10 => "X",
      9 => "IX",
      5 => "V",
      4 => "IV",
      1 => "I"
    }
  end
  
  
end