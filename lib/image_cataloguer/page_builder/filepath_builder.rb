module ImageCataloguer
  class PageBuilder::FilepathBuilder

    def self.get_path(output_folder, type, make = nil, model = nil)
      builder = new(output_folder, type, make, model)
      builder.build_path
    end

    def build_path
      self.send(@type)
    end

    private

      def initialize(output_folder, type, make = nil, model = nil)
        @output_folder = output_folder
        @type = type
        @make = make
        @model = model
        validate_input
      end

      def validate_input
        case @type
        when :make
          if @make.nil? || @make.class != String || @make.empty?
            raise PageBuilder::FilepathBuilder::ArgumentError, "Make cannot be empty."
          end
        when :model
          if @make.nil? || @model.nil? || @make.class != String || @model.class != String || @make.empty? || @model.empty?
            raise PageBuilder::FilepathBuilder::ArgumentError, "Make and model cannot be empty."
          end
        end
      end

      def index
      "#{@output_folder}/index.html"
      end

      def make
        "#{@output_folder}/#{@make}/index.html"
      end

      def model
        "#{@output_folder}/#{@make}/#{@model}.html"
      end

      def method_missing(*args)
        raise PageBuilder::FilepathBuilder::TypeError, "Incorrect type given."
      end
  end
end