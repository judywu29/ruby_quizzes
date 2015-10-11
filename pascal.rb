

module PascalPrint
  
  def self.pascal_print num
    
    #get all of the data in a 2 dimentinal array
    rows = [[1]]
    (1..num).each do |i|
      rows << rows[-1].inject([0]){ |hash, i| hash[-1] = hash[-1] + i; hash << i; hash }
      rows
    end
    # p rows
    # #width:
    width = rows[-1].max.to_s.length
    
    #give each number space: 3*width
    rows.map!{ |row| row.map{ |x| x.to_s.center(width * 3)}.join }
    
    # p rows, put each row in the middle of the longest row
    rows.each{|row| puts row.center(rows[-1].length)}
  end
end

extend PascalPrint
PascalPrint.pascal_print 10

# def test
  # (0..10).each do |i|
    # yield i + 1
  # end
# end
# 
# test{|x| puts x.to_s}
