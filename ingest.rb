require 'logger'
require_relative 'amazon-ses'
require_relative 'variables'

file = ARGV[0]

puts "Processing #{file}..."
output = system "spofford ingest #{file}.json"

if output == false
  log = Logger.new("/home/ec2-user/log/log-ingest-#{current_date}.txt",  "monthly")
  subject = "NCCU: Ingest error"
  message = "#{file} file produced an ingest error"
  log.error message
  send_email(subject, message)
end 


