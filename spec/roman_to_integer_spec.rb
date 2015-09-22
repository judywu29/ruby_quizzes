
require 'spec_helper'
require_relative '../roman_to_integer'

describe String do
  context "#to_arabic_recursive" do
    it "converts a Roman numeral to an integer" do
      expect("MMCLIV".to_arabic_recursive).to eq 2_154
    end
    
    it "converts 'IV' to 4" do
      expect("IV".to_arabic_recursive).to eq 4
    end
    
    it "converts 'MMMMCMXCIX' to 4999" do
      expect("MMMMCMXCIX".to_arabic_recursive).to eq 4999
    end
  end
end