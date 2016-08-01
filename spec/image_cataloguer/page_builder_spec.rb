require 'spec_helper'

RSpec.describe ImageCataloguer::PageBuilder do
  describe "build_pages" do
    before (:each) do
      @images = build_list(:nikon_d80_image, 3)
      @images += build_list(:nikon_d750_image, 3)
      @images += build_list(:panasonic_dmcfz70_image, 3)
      @images += build_list(:panasonic_dmctz80_image, 3)
      @images += build_list(:leica_dlux_image, 3)
      @images += build_list(:leica_dlux3_image, 3)
      @folder_name = "temp"
      @output_folder = File.expand_path(__dir__ + "/../#{@folder_name}")
    end

    after (:each) do
      FileUtils.rm_rf(@output_folder)
    end

    it "should generate an index file" do
      described_class.build_pages(@images, @output_folder)
    end

  end
end