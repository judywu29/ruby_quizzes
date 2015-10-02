class Index
  Index_File = "index.dat"
  
  attr_reader :index_file, :terms, :index
  
  def initialize(index_file_name = Index_File)
    @index_file = index_file_name
    @terms = {} #store all of the terms
    @index = {} #store the documents' indexes
    
    #load @index and terms if the index_file exists
    if File.exists?(@index_file)
      @terms, @index = Marshal::load(File.open(@index_file, 'rb'){ |f| f.read })
    end
    
  end
  
  #add the documents and terms into @terms and @index
  def add *document_names
    # p document_names
    document_names.each do |doc|
      @index[doc] ||= 0
      File.open(doc, 'rb') do |f|
        f.readline.split(" ").each do |term|
          term.downcase!
          @terms[term] = terms.size unless terms.has_key?(term)
          @index[doc] |= 1 << @terms[term] #flag the position at @terms[term] as 1
        end
      end
    end
  end
   
  # finds documents containing all of the specified terms.
  def find *terms 
    result = []
    terms.each do |term|
      @index.each_pair do |doc, mask|
        result << doc if mask[@terms[term]] == 1
      end
    end
    result
  end
  
  # dumps the entire index, showing each term and the documents containing that term
  def dump
    @terms.each_pair do |term, index|
      puts "#{term}: "
      @index.each_pair do |doc, mask|
        puts "#{doc}" if mask[index] == 1
      end
    end 
  end

    
  #save the terms and indexes into the disk
  def save
    File.open(@index_file, 'wb') do |f|
      f.puts Marshal::dump([@terms, @index])
    end
  end
end



if $0 == __FILE__
  index = Index.new
  case ARGV.shift
  when "add"
    # p *ARGV
    index.add *ARGV
    index.save
  when "find"
    p index.find *ARGV.map(&:downcase)
  when "dump"
    index.dump
  else
    puts <<-EOS
    Usage: #$0 add file [file...]       Adds files to index
           #$0 find term [term...]      Lists files containing all term(s)
           #$0 dump                     Dumps raw index data
    EOS
  end
end