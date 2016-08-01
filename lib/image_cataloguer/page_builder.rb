module ImageCataloguer
  class PageBuilder

    def self.build_pages(images, output_folder)
      builder = PageBuilder.new(images, output_folder)
      builder.generate_index
      builder.generate_make_pages
      builder.generate_model_pages
    end

    def generate_page(path, title, links, images)
      html = TemplateWriter.write_to_template(title, links, images)
      write_to_file(path, html)
    end

    def generate_index
      path = get_path(:index)
      title = "Image Catalogue"
      links = get_links(:index)
      images = @images[0..9]
      generate_page(path, title, links, images)
    end

    def generate_make_pages
      images_by_make.keys.each do |make|
        path = get_path(:make, make)
        title = make
        links = get_links(:make, make)
        images = images_by_make[make].take(10)
        generate_page(path, title, links, images)
      end
    end

    def generate_model_pages
      images_by_model.keys.each do |model|
        make = images_by_model[model].first.make
        path = get_path(:model, make, model)
        title = model
        links = get_links(:model, make, model)
        images = images_by_model[model].take(10)
        generate_page(path, title, links, images)
      end
    end

    def get_path(type, make = nil, model = nil)
      FilepathBuilder.get_path(@output_folder, type, make, model)
    end

    def get_links(type, make = nil, model = nil)
      case type
      when :index
        index_links
      when :make
        make_links(make)
      when :model
        model_links(make)
      end
    end

    private

      def initialize(images, output_folder)
        @images = images
        @output_folder = output_folder
        validate_input
      end

      def validate_input
        if @images.class != Array || @images.first.class != ImageCataloguer::Image
          raise ImageCataloguer::PageBuilder::ArgumentError, "Input must be array of Images."
        end
      end

      def index_links
        images_by_make.keys.inject([]) do |links, make|
          url = get_path(:make, make)
          links << Link.new(make, url)
        end
      end

      def make_links(make)
        url = get_path(:index)
        links = [Link.new("Back to Index", url)]
        images_by_model.keys.inject(links) do |links, model|
          if make == get_make(model)
            url = get_path(:model, make, model)
            links << Link.new(model, url)
          end
          links
        end
      end

      def model_links(make)
        url = get_path(:index)
        links = [Link.new("Back to Index", url)]
        url = get_path(:make, make)
        links << Link.new(make, url)
      end

      def images_by_make
        @images.group_by { |image| image.make }
      end

      def images_by_model
        @images.group_by { |image| image.model }
      end

      def get_make(model)
        images_by_model[model].first.make
      end

      def write_to_file(path, html)
        dir = File.dirname(path)
        unless File.directory?(dir)
          FileUtils.mkdir_p(dir)
        end
        File.open(path, "w") { |f| f.write(html) }
      end
  end
end

require_relative 'page_builder/filepath_builder'
require_relative 'page_builder/template_writer'
