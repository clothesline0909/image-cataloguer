require 'pry'
require_relative 'lib/image_cataloguer'

url = ARGV[0]
output_dir = ARGV[1]

# Check for null values

if url == nil || url.empty?
  puts "URL not provided."
  puts "Proper usage: ruby run.rb <url> <output-directory>"
  puts "Please consult the README for more information."
end

if output_dir == nil || output_dir.empty?
  puts "Output directory not provided."
  puts "Proper usage: ruby run.rb <url> <output-directory>"
  puts "Please consult the README for more information."
end

ImageCataloguer.generate_catalogue(url, output_dir)