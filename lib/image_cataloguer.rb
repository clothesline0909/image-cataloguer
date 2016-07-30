require 'pry'

require_relative 'image_cataloguer/xml_parser'
require_relative 'image_cataloguer/image'
require_relative 'image_cataloguer/link'
require_relative 'image_cataloguer/page_builder'
require_relative 'image_cataloguer/page_builder/filepath_builder'
require_relative 'image_cataloguer/page_builder/template_writer'

require_relative 'image_cataloguer/exceptions/syntax_error'
require_relative 'image_cataloguer/exceptions/type_error'
require_relative 'image_cataloguer/exceptions/argument_error'