require 'nokogiri'
require 'open-uri'
require 'active_support/core_ext/hash'
require 'pry'

doc = Nokogiri::XML(open("http://take-home-test.herokuapp.com/api/v1/works.xml"))

data = doc.xpath("//work")

binding.pry