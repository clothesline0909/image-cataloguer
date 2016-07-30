FactoryGirl.define do
  factory :image, class: ImageCataloguer::Image do
    sequence :id
    make "NIKON CORPORATION"
    model "NIKON D80"
    url "http://ih1.redbubble.net/work.31820.1.flat"

    initialize_with { new(id, make, model, url) }
  end
end