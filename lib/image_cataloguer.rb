module ImageCataloguer

  def self.generate_catalogue(url, output_dir)
    works = XMLParser.parse_URL(url)
    images = XMLParser.build_images(works)
    PageBuilder.build_pages(images, output_dir)
  end
end

require_relative 'image_cataloguer/image'
require_relative 'image_cataloguer/link'
require_relative 'image_cataloguer/page_builder'
require_relative 'image_cataloguer/xml_parser'
require_relative 'image_cataloguer/exceptions'