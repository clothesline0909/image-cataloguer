module ImageCataloguer
  class PageBuilder

    def self.generate_catalogue(images, output_folder)
      builder = PageBuilder.new(images, output_folder)
      builder.generate_index
      builder.generate_make_pages
      builder.generate_model_pages
    end

    private

      def generate_index
        links = get_makes.map do |make|
          path = FilepathBuilder.get_path("make", make)
          Link.new(make, path)
        end
        html = TemplateWriter.write_template(@images[0..9])
      end

      def generate_make_pages

      end

      def generate_model_pages

      end

      def get_file(type, name = nil)
        # Get filepath.
        filepath = FilepathBuilder.get_path("index")
        html = TemplateWriter.write_template()
      end

      def initialize(images, output_folder)
        @images = images
        @output_folder = output_folder
      end

      def get_makes
        @images.inject([]) do |makes, image|
          makes << image.make if !makes.include? image.make
        end
      end

      def get_models
        @images.inject([]) do |models, image|
          models << image.model if !models.include? image.model
        end
      end
  end
end

# Given an array of images we need to decompose them into a list of models
# which have makes and 