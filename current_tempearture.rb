require 'savon'

client = Savon.client(wsdl: "http://www.webservicex.net/globalweather.asmx?WSDL")
client.operations # => [:get_weather]
response = client.call(:get_weather, message: { CityName: "Sydney", CountryName: "Australia" }) 
puts response.body