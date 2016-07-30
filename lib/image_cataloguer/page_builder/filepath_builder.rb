module ImageCataloguer
    class PageBuilder::FilepathBuilder

      def self.get_path(type, make = nil, model = nil)
        builder = new(type, make, model)
        path = builder.build_path
        builder.escape_path(path)
      end

      def build_path
        case @type
        when "index"
          "index.html"
        when "make"
          if @make.nil? || @make.empty?
            raise PageBuilder::FilepathBuilder::ArgumentError, "Make cannot be empty."
          end
          "#{@make}/index.html"
        when "model"
          if @make.nil? || @model.nil? || @make.empty? || @model.empty?
            raise PageBuilder::FilepathBuilder::ArgumentError, "Make and model cannot be empty."
          end
          "#{@make}/#{@model}.html"
        else
          raise PageBuilder::FilepathBuilder::TypeError, "Incorrect type given."
        end
      end

      def escape_path(path)
        path.gsub(/\s/, "-").downcase
      end

      private

        def initialize(type, make = nil, model = nil)
          @type = type
          @make = make
          @model = model
        end
    end

end