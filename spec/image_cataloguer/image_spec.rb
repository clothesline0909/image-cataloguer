require 'spec_helper'

RSpec.describe ImageCataloguer::Image do
  describe "to_HTML" do
    before (:each) do
      @images = build_list(:nikon_d80_image, 3)
    end

    it "should convert the image to HTML" do
      image = @images.first
      expect(image.to_HTML).to eq "<img src='#{image.url}' alt='#{image.model}'/>"
    end

    it "should convert an array of images to HTML" do
      html = described_class.to_HTML(@images)
      expected_output = @images.inject("") do |html, image|
        html += image.to_HTML
      end
      expect(html).to eq expected_output
    end
  end
end