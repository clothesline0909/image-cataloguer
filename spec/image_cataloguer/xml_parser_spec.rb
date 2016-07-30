require 'spec_helper'

RSpec.describe ImageCataloguer::XMLParser do
  describe "parseURL" do
    context "when given a valid XML file" do
      before :each do 
        @url = "http://take-home-test.herokuapp.com/api/v1/works.xml"
      end

      it "should not raise any errors on valid input" do
        VCR.use_cassette "api_v1_works" do
          expect{
            described_class.parseURL(@url)
          }.to_not raise_error
        end
      end

      it "should return an array of length 14" do
        VCR.use_cassette "api_v1_works" do
          works = described_class.parseURL(@url)
          expect(works.length).to be 14
        end
      end

      it "should parse the XML into formatted hash objects" do
        VCR.use_cassette "api_v1_works" do
          works = described_class.parseURL(@url)
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
            described_class.parseURL(@url)
          }.to raise_error described_class::SyntaxError, "XML file has incorrect format."
        end
      end
    end
  end
end