require 'amazon-ses'
require 'logger'
require 'variables'

file = ARGV[0]

puts "Processing #{file}..."
system "../marc-to-argot/exe/mta create -t xml nccu #{file}.xml #{path}/add-#{current_date}.json"

