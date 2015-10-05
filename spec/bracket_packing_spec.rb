require 'spec_helper'
require_relative '../bracket_packing'

describe BracketPacking do
  
  let(:bracketpacking){ BracketPacking.new }
  context "#valid?" do
    it "returns true when getting a string like [{(B)}{(B)(B)}] " do
      expect(bracketpacking.valid?("[{(B)}{(B)(B)}]")).to eq true
    end
    it "returns false when getting a string like [{(B}{(B)(B)}] " do
      expect(bracketpacking.valid?("[{(B}{(B)(B)}]")).to eq false
    end
    it "returns false when getting a string like [(B}{(B)(B)}] " do
      expect(bracketpacking.valid?("[(B}{(B)(B)}]")).to eq false
    end
  end
  
  context "#fixing_cloings" do
    it "adds a missing bracket" do
      result = bracketpacking.send :fixing_closings, "[{(B}{(B)(B)}]"
      expect(result).to eq "[{(B)}{(B)(B)}]"
    end
  end
  
  context "#reverse_str" do
    it "returns a reversed str" do
      result = bracketpacking.send :reverse_str, "[foo}"
      expect(result).to eq "{oof]"
    end
  end
  
  context "#fixing" do
    it "fixes '[(B}{(B)(B)}]'" do
      result = bracketpacking.fixing("[(B}{(B)(B)}]")
      expect(result).to eq "[{[(B)]}{(B)(B)}]"
      expect(bracketpacking.valid?(result)).to be true

    end
    
    it "fixes '[{(B}{(B)(B)}]'" do
      result = bracketpacking.fixing("[{(B}{(B)(B)}]")
      expect(result).to eq "[{(B)}{(B)(B)}]"
      expect(bracketpacking.valid?(result)).to be true
      
    end
  end
end