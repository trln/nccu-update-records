require_relative "./helper.rb"

file = ARGV[0]

puts "Processing #{file}..."
puts system "pwd"
#output = system "spofford ingest --config=/home/ec2-user/.spofford-client.yml #{file}"
output = system "curl -v -H'Content-Type: application/json' -H'X-User-Email: genia@trln.org' -H'X-User-Token: sdjSYp8tQ8x-ZNBSHjbj' --data-binary #{file} https://ingest.discovery.trln.org/ingest/nccu"
puts output
puts "Ingest done!"

#Helper.notify_about_errors(output, subject = "Ingest", file)