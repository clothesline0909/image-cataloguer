module ImageCataloguer
  class Image

    attr_accessor :id, :make, :model, :url

    def initialize(id, make, model, url)
      @id = id
      @make = make
      @model = model
      @url = url
    end

    def to_HTML
      "<img src='#{@url}' alt='#{@model}'/>"
    end
  end
end