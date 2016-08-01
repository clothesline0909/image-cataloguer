require 'spec_helper'

RSpec.describe ImageCataloguer::PageBuilder::FilepathBuilder do
  describe "get_path" do
    context "with valid input" do
      before (:each) do
        @image = build(:nikon_d80_image)
        @output_folder = __dir__ + "/catalogue"
      end

      it "should not raise an error" do
        expect{
          described_class.get_path(@output_folder, :index)
        }.to_not raise_error
      end

      it "should generate an index path" do
        path = described_class.get_path(@output_folder, :index)
        expect(path).to eq "#{@output_folder}/index.html"
      end

      it "should generate a make path" do
        path = described_class.get_path(@output_folder, :make, @image.make)
        expect(path).to eq "#{@output_folder}/#{@image.make}/index.html"
      end

      it "should generate a model path" do
        path = described_class.get_path(@output_folder, :model, @image.make, @image.model)
        expect(path).to eq "#{@output_folder}/#{@image.make}/#{@image.model}.html"
      end
    end

    context "with invalid input" do
      before (:each) do
        @image = build(:nikon_d80_image)
        @output_folder = __dir__ + "/catalogue"
      end

      it "should raise an error on invalid type" do
        expect{
          described_class.get_path(@output_folder, :error)
        }.to raise_error described_class::TypeError, "Incorrect type given."
      end

      it "should raise an error on empty make input" do
        expect{
          described_class.get_path(@output_folder, :make, "")
        }.to raise_error described_class::ArgumentError, "Make cannot be empty."
      end

      it "should raise an error on empty make and model input" do
        expect{
          described_class.get_path(@output_folder, :model, "", "")
        }.to raise_error described_class::ArgumentError, "Make and model cannot be empty."
      end
    end
  end
end