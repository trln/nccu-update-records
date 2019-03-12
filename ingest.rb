reqire 'variables'

file = ARGV[0]

puts "Processing #{file}..."
system "spofford ingest #{file}.json"
puts "Done!"


