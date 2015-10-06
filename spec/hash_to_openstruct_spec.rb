require 'spec_helper'
require_relative '../hash_to_openstruct'

describe HashToOpenStruct do
  context "#converting_to_openstruct" do 
    it "converts hash to openstruct object" do
      hash = {'foo' => 1, 'bar'=>{'baz'=>[1,2,3], 'quux'=>42, 'a'=>{x: 1, y: 2, z: 3}}}
      result = HashToOpenStruct.send :converting_to_openstruct, hash
      expect(result).to be_a_kind_of OpenStruct
      expect(result.foo).to eq 1
      expect(result.bar.baz).to eq [1,2,3]
      expect(result.bar.quux).to eq 42
      expect(result.bar.a.x).to eq 1
    end
    
  end
  
end