require 'logger'
require_relative 'amazon-ses'

file = ARGV[0]

puts "Processing #{file}..."
output = system "spofford ingest #{file} 2>ingest_error.log"

if output == false
  error = File.read("/home/ec2-user/nccu-update-records/ingest_error.log")
  subject = "NCCU: Ingest error"
  message = "#{file} file produced an ingest error. \n \n \n \n #{error}. \n \n"
  send_email(subject, message)
end