require 'ostruct'
require 'yaml'

module HashToOpenStruct
  
  #convert the object read from YAML
  def self.load_yaml_openstruct
      @data = self.converting_to_openstruct(YAML::load(File.open('sample.yaml')))
      # p @data.foo
      # p @data.bar.baz
      # p @data.bar.quux
      # p @data.bar.doctors
      # p @data.bar.a.x
  end
  
  def self.load_yaml_hash
    @data = YAML::load(File.open('sample.yaml'))
    p @data['foo']
    p @data['bar']['baz']
    p @data['bar']['quux']
    p @data['bar']['doctors']
    p @data['bar']['a']['x']    
  end
  
  private
  #convert hash to openstruct from top to bottom
  def self.converting_to_openstruct object
    return case object
    when Hash
      object = object.clone
      object.each do |key, value|
        object[key] = converting_to_openstruct(value)
      end
      OpenStruct.new(object)
    when Array
      object.map{|o| converting_to_openstruct(o)}
    else
      object
    end
  end
end
  
# HashToOpenStruct.load_yaml_hash
