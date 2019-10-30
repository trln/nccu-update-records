require_relative "./helper.rb"

file = ARGV[0]

puts "Ingest:\n\n"
puts "Processing #{file}...\n\n"

#ENV['PATH'] = "#{ENV['PATH']}:/home/ec2-user/bin"
#puts `which spofford`

system "spofford ingest --config=/home/ec2-user/.spofford-client.yml #{file}"

puts "\n\n"