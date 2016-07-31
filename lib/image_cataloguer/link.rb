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

    def self.to_HTML(links)
      links.inject("") do |html, link|
        html += link.to_HTML
      end
    end
  end
end