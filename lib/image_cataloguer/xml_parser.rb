require 'nokogiri'
require 'open-uri'

module ImageCataloguer
  class XMLParser

    def self.parse_URL(url)
      doc = Nokogiri::XML(open(url)) { |config| config.strict }
      XMLParser.new(doc).parse_xml
    rescue Nokogiri::XML::SyntaxError
      raise ImageCataloguer::XMLParser::SyntaxError, "XML file has incorrect format."
    end

    def self.build_images(works)
      filter_invalid_works(works)
      works.map do |work|
        Image.new(work.css("id").first.text,
          work.css("make").first.text,
          work.css("model").first.text,
          work.css("url[type='small']").first.text)
      end
    end

    def self.filter_invalid_works(works)
      works.delete_if do |work|
        work.css("id").first == nil || work.css("make").first == nil || 
          work.css("model").first == nil || work.css("url[type='small']").first == nil
      end
    end

    def parse_xml
      works = @doc.xpath("works/work").to_a
    end

    private

      def initialize(doc)
        @doc = doc
      end
  end
end