require 'spec_helper'
require_relative '../postfix_to_infix'

describe String do
  context "#postfix_to_infix" do
    it "converts '2 3 5 + *' to '2 * (3 + 5)' " do
      expect("2 3 5 + *".postfix_to_infix).to eq "2*(3+5)"
    end
    
    it "converts '56 34 213.7 + * 678 -' to '56*(34+213.7)-678' " do
      expect("56 34 213.7 + * 678 -".postfix_to_infix).to eq "56*(34+213.7)-678"
    end
    
    it "converts '1 56 35 + 16 9 - / +' to '1+(56+35)/(16-9)' " do
      expect("1 56 35 + 16 9 - / +".postfix_to_infix).to eq "1+(56+35)/(16-9)"
    end
    
  end
end

