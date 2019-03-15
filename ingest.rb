require 'logger'
require_relative 'amazon-ses'

path = "/home/ec2-user/data/update"
current_date = Time.now.strftime("%d-%m-%Y-%H")

file = ARGV[0]

puts "Processing #{file}..."
output = system "spofford ingest #{file}"

if output == false
  error = File.read("/home/ec2-user/nccu-update-records.error.log")
  file_content = File.read("#{file}")
  subject = "NCCU: Ingest error"
  message = "#{file} file produced an ingest error. \n \n Error: \n \n #{error}. \n \n File: \n \n #{file_content}."
  send_email(subject, message)
end