require 'nokogiri'
require 'open-uri'

module ImageCataloguer
  class XMLParser

    def self.parseURL(url)
      doc = Nokogiri::XML(open(url)) { |config| config.strict }
      XMLParser.new(doc).parse_xml
    rescue Nokogiri::XML::SyntaxError
      raise ImageCataloguer::XMLParser::SyntaxError, "XML file has incorrect format."
    end

    def parse_xml
      @doc.xpath("works/work")
    end

    private

      def initialize(doc)
        @doc = doc
      end
  end
end