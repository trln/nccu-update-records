require './helper.rb'

file = ARGV[0]

puts "Processing #{file}..."
output = system "spofford ingest #{file} 2>error"

Helper.notify_about_errors(output, subject = "Ingest", file)