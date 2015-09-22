
require 'spec_helper'
require_relative '../longest_repeated_substring'

describe String do
  context "#longest_repeated_substring" do
    it "finds the longest repeated substring from 'banana'" do
      expect("banana".longest_repeated_substring).to eq "an"
    end
    
     it "finds the longest repeated substring from 'cabcabca'" do
      expect("cabcabca".longest_repeated_substring).to eq "abc"
    end
    
     it "finds the longest repeated substring from 'ananana'" do
      expect("ananana".longest_repeated_substring).to eq "ana"
    end
  end
end