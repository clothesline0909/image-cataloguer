require 'nokogiri'

module ImageCataloguer
  class PageBuilder::TemplateWriter

    TEMPLATE_PATH = File.expand_path "lib/assets/template.html"

    def self.write_to_template(title, links, images)
      writer = new(title, links, images)
      writer.set_element_content("title", title)
      writer.set_element_content("h1", title)
      writer.set_links(links)
      writer.set_images(images)
      writer.get_HTML
    end

    def get_HTML
      @template.to_html
    end

    def set_element_content(element_name, content)
      element = @template.css(element_name).first
      element.inner_html = content if element
    end

    def set_links(links)
      html = Link.to_HTML(links)
      set_element_content("nav", html)
    end

    def set_images(images)
      html = Image.to_HTML(images)
      header = @template.css("header").first
      header.next.remove
      header.add_next_sibling(html)
    end

    private

      def initialize(title, links, images)
        @title = title
        @links = links
        @images = images
        load_template
        validate_input
      end

      def validate_input
        if @links.nil? || @links.class != Array || @links.first.class != ImageCataloguer::Link
          raise ImageCataloguer::PageBuilder::TemplateWriter::ArgumentError, "Input must be array of Links."
        elsif @images.nil? || @images.class != Array || @images.first.class != ImageCataloguer::Image
          raise ImageCataloguer::PageBuilder::TemplateWriter::ArgumentError, "Input must be array of Images."
        end
      end

      def load_template
        @template = File.open(TEMPLATE_PATH) { |f| Nokogiri::HTML(f) }
      end
  end
end