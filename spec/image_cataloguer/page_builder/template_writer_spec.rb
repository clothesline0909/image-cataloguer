require 'spec_helper'

RSpec.describe ImageCataloguer::PageBuilder::TemplateWriter do
  describe "write_template" do
    context "with the correct template" do
      before (:each) do
        @links = [
          {name: "Link 1", url: "http://www.example1.com"},
          {name: "Link 2", url: "http://www.example2.com"},
          {name: "Link 3", url: "http://www.example3.com"}
        ]
        @images = create_list(:image, 10)
      end
      it "should write the new values into the template" do
        template = described_class.write_template("New Title", @links, @images)
        binding.pry
      end
    end

    context "with an incorrect template" do
    end
  end
end