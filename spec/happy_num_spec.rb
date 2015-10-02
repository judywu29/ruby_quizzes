require 'spec_helper'
require_relative '../happy_num'

describe HappyNum do
  let(:happy_num) { HappyNum.new }
  describe "#get_happiest_num" do
    it "gets the happies_num under 10, it should return 7" do
      expect(happy_num.happiest_num(10)).to eq [7, 4]
    end 
    
    it "gets the happies_num under 100, it should return 7" do
      expect(happy_num.happiest_num(100)).to eq [7, 4]
    end
    
    it "gets the happies_num under 1000, it should return 356" do
      expect(happy_num.happiest_num(1_000)).to eq [356, 5]
    end
    
    it "gets the happies_num under 10_000, it should return 356" do
      expect(happy_num.happiest_num(10_000)).to eq [356, 5]
    end
    
    it "gets the happies_num under 100_000, it should return 78999" do
      expect(happy_num.happiest_num(100_000)).to eq [78999, 6]
    end  
  end
end
