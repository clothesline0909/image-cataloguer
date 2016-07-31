module ImageCataloguer
  class PageBuilder::FilepathBuilder

    def self.get_path(output_folder, type, make = nil, model = nil)
      builder = new(output_folder, type, make, model)
      builder.build_path
    end

    def self.get_link_url(output_folder, type, make = nil, model = nil)
      builder = new(output_folder, type, make, model)
      builder.build_link
    end

    def build_path
      case @type
      when :index
        index_path
      when :make
        make_path
      when :model
        model_path
      end
    end

    def build_link
      case @type
      when :index
        index_link
      when :make
        make_link
      when :model
        model_link
      end
    end

    private

      def initialize(output_folder, type, make = nil, model = nil)
        @output_folder = output_folder
        @type = type
        @make = make
        @model = model
        check_arguments
      end

      def check_arguments
        case @type
        when :index
        when :make
          if @make.nil? || @make.empty?
            raise PageBuilder::FilepathBuilder::ArgumentError, "Make cannot be empty."
          end
        when :model
          if @make.nil? || @model.nil? || @make.empty? || @model.empty?
            raise PageBuilder::FilepathBuilder::ArgumentError, "Make and model cannot be empty."
          end
        else
          raise PageBuilder::FilepathBuilder::TypeError, "Incorrect type given."
        end
      end

      def index_path
      "#{@output_folder}/index.html"
      end

      def make_path
        "#{@output_folder}/#{@make}/index.html"
      end

      def model_path
        "#{@output_folder}/#{@make}/#{@model}.html"
      end
  end
end