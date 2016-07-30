require 'spec_helper'

RSpec.describe ImageCataloguer::PageBuilder::FilepathBuilder do
  describe "get_path" do
    context "with valid input" do
      it "should not raise an error" do
        expect{
          described_class.get_path("index")
        }.to_not raise_error
      end

      it "should generate an index path" do
        path = described_class.get_path("index")
        expect(path).to eq "index.html"
      end

      it "should generate a make path" do
        path = described_class.get_path("make", "NIKON CORPORATION")
        expect(path).to eq "nikon-corporation/index.html"
      end

      it "should generate a model path" do
        path = described_class.get_path("model", "NIKON CORPORATION", "NIKON D80")
        expect(path).to eq "nikon-corporation/nikon-d80.html"
      end
    end

    context "with invalid input" do
      it "should raise an error on invalid type" do
        expect{
          described_class.get_path("error")
        }.to raise_error described_class::TypeError, "Incorrect type given."
      end

      it "should raise an error on empty make input" do
        expect{
          described_class.get_path("make", "")
        }.to raise_error described_class::ArgumentError, "Make cannot be empty."
      end

      it "should raise an error on empty make and model input" do
        expect{
          described_class.get_path("model", "", "")
        }.to raise_error described_class::ArgumentError, "Make and model cannot be empty."
      end
    end
  end
end