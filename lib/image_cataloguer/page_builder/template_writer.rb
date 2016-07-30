require 'nokogiri'

module ImageCataloguer
  class PageBuilder::TemplateWriter

    TEMPLATE_PATH = File.expand_path "lib/assets/template.html"

    def self.write_template(title, links, images)
      writer = new(title, links, images)
      writer.set_element_content("title", title)
      writer.set_element_content("h1", title)
      writer.set_links(links)
      writer.set_images(images)
      writer.get_HTML
    end

    def get_images_HTML(images)
      images_HTML = images.inject("") do |html, image|
        html += image.to_HTML
      end
    end

    def get_links_HTML(links)
      links_HTML = links.inject("") do |html, link|
        html += link.to_HTML
      end
    end

    def get_HTML
      @template.to_html
    end

    def set_element_content(element_name, content)
      element = @template.css(element_name).first
      element.inner_html = content if element
    end

    def set_links(links)
      links_HTML = get_links_HTML(links)
      set_element_content("nav", links_HTML)
    end

    def set_images(images)
      images_HTML = get_images_HTML(images)
      header = @template.css("header").first
      header.next.remove
      header.add_next_sibling(images_HTML)
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
  end
end