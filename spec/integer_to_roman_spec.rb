require 'spec_helper'
require_relative '../integer_to_roman'

describe Integer do
  context "#to_roman" do
    it "converts 152 to 'CLII'" do
      expect(152.to_roman).to eq "CLII"
      
    end
    
    it "converts 1904 to 'MCMIV'" do
      expect(1904.to_roman).to eq "MCMIV"
      
    end
    
    it "converts 4 to 'IV'" do
      expect(4.to_roman).to eq "IV"
      
    end
    
    it "converts 3 to 'III'" do
      expect(3.to_roman).to eq "III"
      
    end
    
    it "converts 0 to ''" do
      expect(0.to_roman).to eq ""
      
    end
    
    it "converts 2013 to 'MMXIII" do
      expect(2013.to_roman).to eq "MMXIII"
      
    end

  end
end