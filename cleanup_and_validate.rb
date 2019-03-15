require 'variables'
file = ARGV[0]

puts "Processing #{file}..."

system "ruby xml_cleanup.rb #{file} > #{VARIABLES::PATH}/update-#{VARIABLES::CURRENT_DATE}-better.xml"
system "xmllint --recover #{VARIABLES::PATH}/update-#{VARIABLES::CURRENT_DATE}-better.xml > #{VARIABLES::PATH}/update-#{VARIABLES::CURRENT_DATE}-clean.xml"

puts "Done!"