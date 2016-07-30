module ImageCataloguer
  class Link

    attr_accessor :name, :url

    def initialize(name, url)
      @name = name
      @url = url
    end

    def to_HTML
      "<a href='#{@url}'>#{@name}</a>"
    end
  end
end