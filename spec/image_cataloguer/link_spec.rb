require 'spec_helper'

RSpec.describe ImageCataloguer::Link do
  describe "to_HTML" do
    before (:each) do
      @links = build_list(:link, 3)
    end

    it "should convert the link to HTML" do
      @link = @links.first
      expect(@link.to_HTML).to eq "<a href='#{@link.url}'>#{@link.name}</a>"
    end

    it "should convert an array of links to HTML" do
      html = described_class.to_HTML(@links)
      expected_output = @links.inject("") do |html, link|
        html += link.to_HTML
      end
      expect(html).to eq expected_output
    end
  end
end