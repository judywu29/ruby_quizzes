require 'spec_helper'
require_relative '../weird_num'

describe Integer do
  context "#get_divisors" do
    it "gets all of its divisors" do
      expect(36.get_divisors).to eq [1, 2, 3, 4, 6, 9, 12, 18, 36]
    end
  end
  
  context "#sum_in_subset" do
    it "is a semi-perfect number when it's 12" do
      expect(12.sum_in_subset?([6,4,3,2,1])).to eq true
    end
    
    it "is a semi-perfect number when it's 18" do
      expect(18.sum_in_subset?([9,6,3,2,1])).to eq true
    end
    
    it "is not a semi-perfect number when it's 15" do
      expect(15.sum_in_subset?([5,3,2,1])).to eq false
    end
  end
  
  context "#weird?" do
    it "is a weird number when it's 70" do
      expect(70.weird?).to eq true
    end
    
    it "is not a weird number when it's 42" do
      expect(42.weird?).to eq false
    end
    
    it "is a weird number when it's 836" do
      expect(836.weird?).to eq true
    end
  end
end
