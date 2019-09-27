require_relative "./helper.rb"

file = ARGV[0]

puts "Processing #{file}..."

output = system "spofford ingest #{file}"

puts output
puts "Ingest done!"

#Helper.notify_about_errors(output, subject = "Ingest", file)