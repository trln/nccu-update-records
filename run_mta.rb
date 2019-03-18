require 'logger'
require_relative 'amazon-ses'
require './variables.rb'

file = ARGV[0]

puts "Processing #{file}..."
output = system "../marc-to-argot/exe/mta create -t xml nccu #{file} #{Variables::PATH}/add-#{Variables::CURRENT_DATE}.json 2>mta_error.log"

if output == false
  error = File.read("/home/ec2-user/nccu-update-records/mta_error.log")
  subject = "NCCU: Marc-to-argot error"
  message = "#{file} file produced a marc-to-argot error: \n \n \n \n #{error}. \n \n"
  send_email(subject, message)
end

puts "Done!" 

