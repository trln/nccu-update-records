require './helper.rb'

file = ARGV[0]

puts "Processing #{file}..."
output = system "spofford ingest #{file} 2>>/home/ec2-user/nccu-update-records/error.log"

Helper.notify_about_errors(output, subject = "Ingest", file)