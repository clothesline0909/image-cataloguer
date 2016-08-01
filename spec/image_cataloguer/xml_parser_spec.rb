require 'spec_helper'

RSpec.describe ImageCataloguer::XMLParser do
  describe "parse_URL" do
    context "when given a valid XML file" do
      before :each do 
        @url = "http://take-home-test.herokuapp.com/api/v1/works.xml"
      end

      it "should not raise an error" do
        VCR.use_cassette "api_v1_works" do
          expect{
            described_class.parse_URL(@url)
          }.to_not raise_error
        end
      end

      it "should return an array of length 14" do
        VCR.use_cassette "api_v1_works" do
          works = described_class.parse_URL(@url)
          expect(works.length).to be 14
        end
      end

      it "should parse the XML into formatted hash objects" do
        VCR.use_cassette "api_v1_works" do
          works = described_class.parse_URL(@url)
          first_work = works[0]
          expect(first_work.key? "id")
          expect(first_work.key? "make")
          expect(first_work.key? "model")
          expect(first_work.key? "url")
        end
      end
    end

    context "when given an invalid XML file" do
      before :each do
        @url = "http://www.example.com"
      end

      it "should raise an error on invalid input" do
        VCR.use_cassette "invalid_xml" do
          expect{
            described_class.parse_URL(@url)
          }.to raise_error described_class::SyntaxError, "XML file has incorrect format."
        end
      end
    end
  end

  describe "build_images" do
    context "when given a valid array of XML nodes" do
      before (:each) do
        VCR.use_cassette "api_v1_works" do
          url = "http://take-home-test.herokuapp.com/api/v1/works.xml"
          @works = XMLParser.parse_URL(url)
        end
      end

      it "should not raise an error" do
        expect{
          XMLParser.build_images(@works)
        }.to_not raise_error
      end

      it "should return an array of images" do
        images = XMLParser.build_images(@works)
        expect(images.first.class).to eq ImageCataloguer::Image
      end

      it "should filter out invalid images" do
        expect(@works.length).to eq 14
        images = XMLParser.build_images(@works)
        expect(images.length).to eq 12
      end

      it "should return an array of length 12" do
        images = XMLParser.build_images(@works)
        expect(images.length).to eq 12
      end
    end
  end
end