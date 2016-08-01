require 'spec_helper'

RSpec.describe ImageCataloguer::PageBuilder::TemplateWriter do
  describe "write_to_template" do
    context "with correct input" do
      before (:each) do
        @title = "New Title"
        @links = build_list(:link, 5)
        @images = build_list(:nikon_d80_image, 10)
      end

      it "should not raise an error" do
        expect{
          described_class.write_to_template(@title, @links, @images)
        }.to_not raise_error
      end

      it "should write the new values into the template" do
        html = described_class.write_to_template(@title, @links, @images)
        doc = Nokogiri::HTML(html)
        expect(doc.css("title").first.text).to eq @title
        expect(doc.css("h1").first.text).to eq @title
        link = doc.css("nav").first.child
        expect(link.name).to eq "a"
        expect(link.attributes["href"].value).to eq @links.first.url
        expect(link.child.text).to eq @links.first.name
        expect(doc.css("nav").children.length).to eq @links.length
        image = doc.css("img").first
        expect(image.attributes["src"].value).to eq @images.first.url
        expect(image.attributes["alt"].value).to eq @images.first.model
        expect(doc.css("img").length).to eq @images.length
      end
    end

    context "with incorrect input" do
      before (:each) do
        @title = "New Title"
      end

      it "should raise an error on non-array input" do
        links = "error"
        images = @images = build_list(:nikon_d80_image, 10)
        expect{
          described_class.write_to_template(@title, links, images)
        }.to raise_error described_class::ArgumentError, "Input must be array of Links."
      end

      it "should raise an error on non-Link array input" do
        links = ["error"]
        images = @images = build_list(:nikon_d80_image, 10)
        expect{
          described_class.write_to_template(@title, links, images)
        }.to raise_error described_class::ArgumentError, "Input must be array of Links."
      end

      it "should raise an error on non-array input" do
        links = build_list(:link, 5)
        images = "error"
        expect{
          described_class.write_to_template(@title, links, images)
        }.to raise_error described_class::ArgumentError, "Input must be array of Images."
      end

      it "should raise an error on non-Link array input" do
        links = build_list(:link, 5)
        images = ["error"]
        expect{
          described_class.write_to_template(@title, links, images)
        }.to raise_error described_class::ArgumentError, "Input must be array of Images."
      end
    end
  end
end