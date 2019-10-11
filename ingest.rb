require_relative "./helper.rb"

file = ARGV[0]

puts "Ingest:\n\n"
puts "Processing #{file}...\n\n"

#ENV['PATH'] = "#{ENV['PATH']}:/home/ec2-user/bin"
#puts `which spofford`

system "spofford ingest --config=/home/ec2-user/.spofford-client.yml #{file}"
#system "curl -v -H'Content-Type: application/json' -H'X-User-Email: genia@trln.org' -H'X-User-Token: sdjSYp8tQ8x-ZNBSHjbj' --data-binary @#{file} https://ingest.discovery.trln.org/ingest/nccu"
