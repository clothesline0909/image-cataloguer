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

To run this project you must have Ruby installed (tested version 2.3.0). To install this version using RVM use:

    $ rvm install 2.3.0

If already installed, you can switch versions using:

    $ rvm use 2.3.0

Clone the repository:

    $ git clone https://github.com/clarkbab/image-cataloguer.git
    $ cd image-cataloguer
    $ gem install bundler
    $ bundle install

## Running

To run the project you must provide a URL that points to a valid XML file containing EXIF image data. You must also specify the **absolute path** to the output folder. The output folder need not exist.

    $ ruby run.rb <xml-url> <output-path>

For example:

    $ ruby run.rb http://www.example.com/exif.xml /home/johndoe/catalogue

## Testing

Testing is carried out using RSpec either individually or in groups.

    $ rspec                                               # Performs all files matching *_spec.rb in spec and sub-folders.
    $ rpsec spec/image_cataloguer/page_builder            # Runs all spec files in page_builder and sub-folders.
    $ rspec spec/image_cataloguer/xml_parser_spec.rb      # Runs a single spec file.

## Licence

This project, image-cataloguer, is licensed under the GNU Lesser General Public License.


