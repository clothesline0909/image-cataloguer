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
        # Create file using filepathbuilder
        file = get_file("index")
        
        @images[0..10].each do |image|

        end
      end

      def generate_make_pages

      end

      def generate_model_pages

      end

      def get_file(type, name = nil)
        # Get filepath.
        filepath = FilepathBuilder.get_path("index")
        # Create file in memory from template. Possibly using TemplateWriter.
        # Template writer will take the path to the template, as well as
      end

      def initialize(images, output_folder)
        @images = images
        @output_folder = output_folder
      end
  end
end