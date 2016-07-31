FactoryGirl.define do
  factory :nikon_d80_image, class: ImageCataloguer::Image do
    sequence :id
    make "NIKON CORPORATION"
    model "NIKON D80"
    url "http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg"

    initialize_with { new(id, make, model, url) }
  end

  factory :nikon_d750_image, class: ImageCataloguer::Image do
    sequence :id
    make "NIKON CORPORATION"
    model "NIKON D750"
    url "http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg"

    initialize_with { new(id, make, model, url) }
  end

  factory :panasonic_dmcfz70_image, class: ImageCataloguer::Image do
    sequence :id
    make "Panasonic"
    model "DMC-FZ30"
    url "http://ih1.redbubble.net/work.3745978.1.flat,135x135,075,f.jpg"

    initialize_with { new(id, make, model, url) }
  end

  factory :panasonic_dmctz80_image, class: ImageCataloguer::Image do
    sequence :id
    make "Panasonic"
    model "DMC-TZ80"
    url "http://ih1.redbubble.net/work.3745978.1.flat,135x135,075,f.jpg"

    initialize_with { new(id, make, model, url) }
  end

  factory :leica_dlux_image, class: ImageCataloguer::Image do
    sequence :id
    make "LEICA"
    model "D-LUX 3"
    url "http://ih1.redbubble.net/work.2729606.1.flat,135x135,075,f.jpg"

    initialize_with { new(id, make, model, url) }
  end

  factory :leica_dlux3_image, class: ImageCataloguer::Image do
    sequence :id
    make "LEICA"
    model "D-LUX 3"
    url "http://ih1.redbubble.net/work.2729606.1.flat,135x135,075,f.jpg"

    initialize_with { new(id, make, model, url) }
  end
end