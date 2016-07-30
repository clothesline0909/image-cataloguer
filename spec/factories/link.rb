FactoryGirl.define do
  factory :link, class: ImageCataloguer::Link do
    name "Link Text"
    url "http://www.example.com"

    initialize_with { new(name, url) }
  end
end