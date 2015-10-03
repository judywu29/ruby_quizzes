require 'spec_helper'
require_relative '../numeric_maze'

describe NumMazer do
  let(:num_mazer) { NumMazer.new(2, 9) }
  context "#initalize" do
    it "initializes the instance variables" do
      expect(num_mazer.paths).to be_kind_of Set
      expect(num_mazer.start).to be 2
      expect(num_mazer.target).to be 9
      expect(num_mazer.upper_bound).to be 22
    end
  end
  
  context "#find_path" do
    it "finds a path from 2 to 9" do
      expect(num_mazer.find_path([[2]])).to eq [2, 4, 8, 16, 18, 9]
    end
    
    it "finds a path from 9 to 2" do
      num_mazer2 = NumMazer.new(9, 2)
      expect(num_mazer2.find_path([[9]])).to eq [9, 18, 20, 10, 12, 6, 8, 4, 2]
    end
  end
end