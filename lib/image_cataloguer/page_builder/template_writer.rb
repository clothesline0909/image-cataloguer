require 'nokogiri'

module ImageCataloguer
  class PageBuilder::TemplateWriter

    TEMPLATE_PATH = "../../lib/assets/template.html"

    def self.write_template(title, links, images)
      writer = new(title, links, images)
      writer.set_element_content("title", title)
      writer.set_element_content("h1", title)
      writer.set_element_content("nav", get_links_HTML(links))
      writer.get_HTML
    end

    private

      def initialize(title, links, images)
        @title = title
        @links = links
        @images = images
        load_template
      end

      def load_template
        @template = File.open(TEMPLATE_PATH) { |f| Nokogiri::HTML(f) }
      end

      def get_images_HTML(images)
        images_HTML = images.inject("") do |html, image|
          html += "<img src=#{image.url} alt=#{image.model}/>"
        end
      end

      def get_links_HTML(links)
        links_HTML = links.inject("") do |html, link|
          html += "<a href=#{link.url}>#{link.name}</a>"
        end
      end

      def get_HTML
        template.to_html
      end

      def set_element_content(element_name, content)
        element = template.css(element_name).first
        element.content = content if element
        template
      end
  end
end