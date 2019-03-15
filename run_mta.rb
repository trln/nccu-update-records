require 'logger'
require_relative 'amazon-ses'
require 'variables'

file = ARGV[0]

puts "Processing #{file}..."
output = system "../marc-to-argot/exe/mta create -t xml nccu #{file} #{VARIABLES::PATH}/add-#{VARIABLES::CURRENT_DATE}.json 2>error.log"

if output == false
  error = File.read("/home/ec2-user/nccu-update-records/error.log")
  subject = "NCCU: Marc-to-argot error"
  message = "#{file} file produced a marc-to-argot error: \n \n \n \n #{error}. \n \n"
  send_email(subject, message)
end  

