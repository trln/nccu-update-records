require_relative "./helper.rb"

file = ARGV[0]

puts "Processing #{file}..."
system "spofford ingest #{file}"

#Helper.notify_about_errors(output, subject = "Ingest", file)