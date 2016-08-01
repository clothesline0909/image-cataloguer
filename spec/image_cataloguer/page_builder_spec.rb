require 'spec_helper'

RSpec.describe ImageCataloguer::PageBuilder do
  describe "build_pages" do
    context "with valid image array" do
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
        expect(File.exist?("#{@output_folder}/index.html")).to eq true
      end

      it "should have 3 links on the index page" do
        described_class.build_pages(@images, @output_folder)
        doc = Nokogiri::HTML(File.open("#{@output_folder}/index.html", "r"))
        expect(doc.css("a").length).to eq 3
      end

      it "should have 3 images on the index page" do
        @images = build_list(:nikon_d80_image, 3)
        described_class.build_pages(@images, @output_folder)
        doc = Nokogiri::HTML(File.open("#{@output_folder}/index.html", "r"))
        expect(doc.css("img").length).to eq 3
      end

      it "should have a maximum 10 images on the index page" do
        expect(@images.length).to eq 18
        described_class.build_pages(@images, @output_folder)
        doc = Nokogiri::HTML(File.open("#{@output_folder}/index.html", "r"))
        expect(doc.css("img").length).to eq 10
      end

      it "should generate a make folder" do
        described_class.build_pages(@images, @output_folder)
        make = @images.first.make
        expect(File.directory?("#{@output_folder}/#{make}")).to eq true
      end

      it "should generate a make page" do
        described_class.build_pages(@images, @output_folder)
        make = @images.first.make
        expect(File.exist?("#{@output_folder}/#{make}/index.html")).to eq true
      end

      it "should have an index link on the make page" do
        described_class.build_pages(@images, @output_folder)
        make = @images.first.make
        doc = Nokogiri::HTML(File.open("#{@output_folder}/#{make}/index.html", "r"))
        expect(doc.css("a").first.text).to eq "Back to Index"
      end

      it "should have 3 links on the make page" do
        described_class.build_pages(@images, @output_folder)
        make = @images.first.make
        doc = Nokogiri::HTML(File.open("#{@output_folder}/#{make}/index.html", "r"))
        expect(doc.css("a").length).to eq 3
      end

      it "should have 6 images on the make page" do
        expect(@images.length).to eq 18
        described_class.build_pages(@images, @output_folder)
        make = @images.first.make
        doc = Nokogiri::HTML(File.open("#{@output_folder}/#{make}/index.html", "r"))
        expect(doc.css("img").length).to eq 6
      end

      it "should have a maximum 10 images on the make page" do
        @images += build_list(:nikon_d80_image, 12)
        expect(@images.length).to eq 30
        described_class.build_pages(@images, @output_folder)
        make = @images.first.make
        doc = Nokogiri::HTML(File.open("#{@output_folder}/#{make}/index.html", "r"))
        expect(doc.css("img").length).to eq 10
      end

      it "should generate a model page" do
        described_class.build_pages(@images, @output_folder)
        make = @images.first.make
        model = @images.first.model
        expect(File.exist?("#{@output_folder}/#{make}/#{model}.html")).to eq true
      end

      it "should have an index link on the model page" do
        described_class.build_pages(@images, @output_folder)
        make = @images.first.make
        model = @images.first.model
        doc = Nokogiri::HTML(File.open("#{@output_folder}/#{make}/#{model}.html", "r"))
        expect(doc.css("a").first.text).to eq "Back to Index"
      end

      it "should have 3 links on the model page" do
        described_class.build_pages(@images, @output_folder)
        make = @images.first.make
        model = @images.first.model
        doc = Nokogiri::HTML(File.open("#{@output_folder}/#{make}/#{model}.html", "r"))
        expect(doc.css("a").length).to eq 2
      end

      it "should have 3 images on the model page" do
        expect(@images.length).to eq 18
        described_class.build_pages(@images, @output_folder)
        make = @images.first.make
        model = @images.first.model
        doc = Nokogiri::HTML(File.open("#{@output_folder}/#{make}/#{model}.html", "r"))
        expect(doc.css("img").length).to eq 3
      end

      it "should have a maximum 10 images on the make page" do
        @images += build_list(:nikon_d80_image, 12)
        expect(@images.length).to eq 30
        described_class.build_pages(@images, @output_folder)
        make = @images.first.make
        doc = Nokogiri::HTML(File.open("#{@output_folder}/#{make}/index.html", "r"))
        expect(doc.css("img").length).to eq 10
      end
    end

    context "with invalid image array" do
      before (:each) do
        @folder_name = "temp"
        @output_folder = File.expand_path(__dir__ + "/../#{@folder_name}")
      end

      it "should raise an error on non-array input" do
        @images = "error"
        expect{
          described_class.build_pages(@images, @output_folder)
        }.to raise_error described_class::ArgumentError, "Input must be array of Images."
      end

      it "should raise an error on non-Image array input" do
        @images = ["errors"]
        expect{
          described_class.build_pages(@images, @output_folder)
        }.to raise_error described_class::ArgumentError, "Input must be array of Images."
      end
    end
  end
end