if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end


require 'net/http'
require 'uri'
require 'rexml/document'
require 'certified'


uri = URI.parse("http://www.cbr.ru/scripts/XML_daily.asp")

response = Net::HTTP.get_response(uri)
doc = REXML::Document.new(response.body)

currency_usd = doc.root.elements["Valute[@ID='R01235']"]
currency_title_usd = currency_usd.elements['Name'].text
currency_value_usd = currency_usd.elements['Value'].text

currency_eur = doc.root.elements["Valute[@ID='R01239']"]
currency_title_eur = currency_eur.elements['Name'].text
currency_value_eur = currency_eur.elements['Value'].text


puts "#{currency_title_usd}: #{currency_value_usd} pyб."
puts "#{currency_title_eur}: #{currency_value_eur} руб."