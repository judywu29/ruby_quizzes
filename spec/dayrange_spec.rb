require 'spec_helper'
require_relative '../dayrange'

describe DayRange do
  describe "#create_abbrev_num_hash" do
    context "with default input argument" do
      it "creates the @day_abbrev_hash class instance varialbe" do
        # DayRange.create_abbrev_num_hash
        hash = DayRange.class_eval{ @day_abbrev_hash }
        expect(hash.size).to eq 7
        expect(hash).to include(1 => 'Mon', 2 => 'Tue', 7 => 'Sun')
      end
    end
    
    context "with length of abbrev = 2 " do
      it "creates the @day_abbrev_hash class instance varialbe" do
        DayRange.create_abbrev_num_hash(2)
        hash = DayRange.class_eval{ @day_abbrev_hash }
        expect(hash.size).to eq 7
        expect(hash).to include(1 => 'Mo', 2 => 'Tu', 7 => 'Su')
      end
    end
  end
 
  before(:each) do
    DayRange.create_abbrev_num_hash
  end
  
  describe "#initialize" do
    context "with valid days: [1,2,3,4,5,6,7]" do
      it "returns array of integer days" do
        args = (1..7).map(&:to_s)
        expect(DayRange.new(args).days).to include(1,2,3,4,5,6,7)
      end
    end
    
    context "with valid days: ['Mon', 'Tue', 'Sun']" do
      it "returns array fo integer days" do
        args = %w(Mon Tue Sun)
        expect(DayRange.new(args).days).to include(1,2,7)
      end
    end
    
    context "with valid days: ['Tuesday', 'Friday', 'Saturday' ]" do
      it "returns array fo integer days" do
        args = %w(Tuesday Friday Saturday)
        expect(DayRange.new(args).days).to include(2,5,6)
      end
    end
    
    context "with invalid days: ['Fake', 'Tue', 'Sat']" do
      it 'raise Argument Error' do
        args = %w(Fake Tue Sat)
        expect{DayRange.new(args)}.to raise_error(ArgumentError)
      end
    end
  end
  
  describe "#num_ranges" do
    context "with numbers: [1,2,3,6,7]" do
      it "returns [[1,3],[6,7]]" do
        args = %w(1 2 3 6 7)
        expect(DayRange.new(args).send :num_ranges).to include([1,3], [6,7])
      end
    end
    
    context "with numbers: [1,2,3,5,7]" do
      it "returns [[1,3],[5,5],[7,7]]" do
        args = %w(1 2 3 5 7)
        expect(DayRange.new(args).send :num_ranges).to include([1,3], [5,5],[7,7])
      end
    end
  end
  
  describe "#to_s" do
    context "with numbers: [1,2,3,6,7]" do
      it "returns 'Mon-Wed,Sat,Sun" do
        args = %w(1 2 3 6 7)
        expect(DayRange.new(args).to_s).to eq "Mon-Wed,Sat,Sun"
      end
    end
    
    context "with strings:  ['Tuesday', 'Friday', 'Saturday' ]" do
      it "returns 'Tue,Fri,Sat" do
        args = %w(Tuesday Friday Saturday)
        expect(DayRange.new(args).to_s).to eq "Tue,Fri,Sat"
      end
    end
    
    context "with strings:  ['Mon', 'Tue', 'Fri', 'Sat', Sun']" do
      it "returns 'Mon,Tue,Fri-Sun" do
        args = %w(Mon Tue Fri Sat Sun)
        expect(DayRange.new(args).to_s).to eq "Mon,Tue,Fri-Sun"
      end
    end
  end
  
end