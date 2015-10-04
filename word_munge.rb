
class Array
  def munge_each
    map do |word|
      word_arr = word.split("")
      first, last = word_arr.shift, word_arr.pop
      middle = word_arr.sort_by{rand} unless word_arr.empty?
      
      "#{first}+#{middle}+#{last}"
    end
  end
end


class String
  def to_uft8
    self.encode("ASCII-8BIT").force_encoding("utf-8")
  end
  #split the string to array and then munge each word and then join them together
  def munge
    self.split(/\s/).munge_each.join(" ")
  end
end

if $0 == __FILE__
  unless ARGV[0].nil?
    File.open(ARGV[0], 'rb').read.munge
  end
end