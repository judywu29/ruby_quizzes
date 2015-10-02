require 'spec_helper'
require_relative '../index_and_query'

describe Index do
  let(:idx){ Index.new }
  context "#initialize" do
    it "initializes instance variables" do
      expect(idx.index_file).to eq "index.dat"
      expect(idx.terms).to be_kind_of Hash
      expect(idx.index).to be_kind_of Hash
    end
    
    it "load the data from the index.dat" do

      expect(idx.terms).to include "the" => 0
      expect(idx.index).to include "doc1" => 15
    end
  end
  
  
  context "#add" do
    it "adds documents and terms to the @terms and @index" do
      idx.add "doc1", "doc2", "doc3"
      expect(idx.terms).to include("the" => 0)
      expect(idx.terms).to include("to" =>9)
      expect(idx.terms.size).to eq 10
      
      expect(idx.index).to include("doc1" => 15)
      expect(idx.index).to include("doc2" => 117)
      expect(idx.index).to include("doc3" => 899)
    end
  end
  
  context "#find" do
    it "finds 'the' in three documents, and returns [doc1, doc2, doc3]" do
      idx.add "doc1", "doc2", "doc3"
      expect(idx.find 'the').to eq ["doc1", "doc2", "doc3"]
    end
    it "finds 'brown' in three documents, and returns ['doc1', 'doc2']" do
      idx.add "doc1", "doc2", "doc3"
      expect(idx.find 'brown').to eq ["doc1", "doc2"]
    end
    
    it "finds 'cut' in three documents, and returns ['doc3']" do
      idx.add "doc1", "doc2", "doc3"
      expect(idx.find 'cut').to eq ["doc3"]
    end
  end
  
  context "#dump" do
    it "dumps the entire index, showing each term and the documents containing that term" do
      idx.add "doc1", "doc2", "doc3"
      expect{ idx.dump }.to output(/the: \ndoc1\ndoc2\ndoc3\nquick: \ndoc1\ndoc3\nbrown: \ndoc1\ndoc2\n/).to_stdout
    end
  end

  context "#save" do
    it "saves to the index.dat file" do
      idx.add "doc1", "doc2", "doc3"
      idx.save
      expect(File.exists?(idx.index_file)).to be true
      # expect(idx.index_file).to be_an_existing_file
    end
  end
    
end