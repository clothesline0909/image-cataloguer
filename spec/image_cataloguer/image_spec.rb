require 'spec_helper'

RSpec.describe ImageCataloguer::Image do
  describe "to_HTML" do
    before (:each) do
      @image = build(:nikon_d80_image)
    end

    it "should convert the image to HTML" do
      expect(@image.to_HTML).to eq "<img src='#{@image.url}' alt='#{@image.model}'/>"
    end
  end
end