require_relative "./helper.rb"

file = ARGV[0]

puts "Processing #{file}..."

#output = system "spofford ingest --config=/home/ec2-user/.spofford-client.yml #{file}" #spofford ingest didn't work via cron
system "curl -v -H'Content-Type: application/json' -H'X-User-Email: genia@trln.org' -H'X-User-Token: sdjSYp8tQ8x-ZNBSHjbj' --data-binary @#{file} https://ingest.discovery.trln.org/ingest/nccu"
