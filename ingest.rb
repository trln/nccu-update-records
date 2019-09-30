require_relative "./helper.rb"

file = ARGV[0]

puts "Processing #{file}..."
puts system "pwd"
output = system "spofford ingest --config=/home/ec2-user/.spofford-client.yml #{file}"

puts output
puts "Ingest done!"

#Helper.notify_about_errors(output, subject = "Ingest", file)