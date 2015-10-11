
if $0 == __FILE__
  
  #get the the board size from the input type
  size = ARGV.first && ARGV.first =~ /\A-s(?:ize)?\Z/ ? ARGV.last.to_i : 5
  
  
  
end