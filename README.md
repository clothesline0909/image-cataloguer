# Image Cataloguer

A batch processor that takes an XML file of EXIF exported data and produces a catalog of images.

## Environments

This project was tested on Ubuntu 14.04.

## System Dependencies & Configuration

This application requires Ruby >= 2.3.0.

To check your version run:

    $ ruby -v

To install Ruby visit: http://rubyinstaller.org/.

It is recommended to use a Ruby version manager such as RVM. For information on RVM visit: https://rvm.io/rvm/install

## Installation

To run this project you must have Ruby installed (tested version 2.3.0).

    $ git clone https://github.com/clarkbab/image-cataloguer.git
    $ cd image-cataloguer
    $ gem install bundler
    $ bundle install

## Running



## Testing

Testing is carried out using RSpec either individually or in groups.

    $ rspec                                               # Performs all files matching *_spec.rb in spec and sub-folders.
    $ rpsec spec/image_cataloguer/page_builder            # Runs all spec files in page_builder and sub-folders.
    $ rspec spec/image_cataloguer/xml_parser_spec.rb      # Runs a single spec file.

## Licence

This project, image-cataloguer, is licensed under the GNU Lesser General Public License.


