require './variables.rb'
file = ARGV[0]

puts "Processing #{file}..."

system "ruby xml_cleanup.rb #{file} > #{Variables::PATH}/update-#{Variables::CURRENT_DATE}-better.xml"
system "xmllint --recover #{Variables::PATH}/update-#{Variables::CURRENT_DATE}-better.xml > #{Variables::PATH}/update-#{Variables::CURRENT_DATE}-clean.xml"

puts "Done!"