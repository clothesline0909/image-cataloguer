require 'spec_helper'

RSpec.describe ImageCataloguer::Link do
  describe "to_HTML" do
    before (:each) do
      @link = build(:link)
    end

    it "should convert the link to HTML" do
      expect(@link.to_HTML).to eq "<a href='#{@link.url}'>#{@link.name}</a>"
    end
  end
end