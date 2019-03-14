include 'variables'

file = ARGV[0]

puts "Processing #{file}..."

system "ruby xml_cleanup.rb #{file} > /home/ec2-user/data/update/update-#{current_date}-better.xml"
system "xmllint --recover #{path}/update-#{current_date}-better.xml > #{path}/update-#{current_date}-clean.xml"

puts "Done!"