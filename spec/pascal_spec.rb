require 'spec_helper'
require_relative '../pascal'

describe PascalPrint do
  context "#pascal_print" do
    it "prits the 5 rows of numbers" do
      expect(PascalPrint.pascal_print(4)).to output("6").to_stdout
    end
  end
end