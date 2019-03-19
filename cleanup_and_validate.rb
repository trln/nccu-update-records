require './helper.rb'
file = ARGV[0]

puts "Processing #{file}..."

system "ruby xml_cleanup.rb #{file} > #{Helper::PATH}/update-#{Helper::CURRENT_DATE}-better.xml"
system "xmllint --recover #{Helper::PATH}/update-#{Helper::CURRENT_DATE}-better.xml > #{Helper::PATH}/update-#{Helper::CURRENT_DATE}-clean.xml"

puts "Done!"