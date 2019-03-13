require_relative 'variables'

file = ARGV[0]

puts "Processing #{file}..."
path = "/home/ec2-user/data"

system "ruby xml_cleanup.rb #{file} > #{path}/update-#{current_date}-better.xml"
system "xmllint --recover #{path}/update-#{current_date}-better.xml > #{path}/update-#{current_date}-clean.xml"

puts "Done!"