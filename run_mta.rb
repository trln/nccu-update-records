require 'logger'
path = "/home/ec2-user/data/update"
current_date = Time.now.strftime("%d-%m-%Y-%H")

file = ARGV[0]

puts "Processing #{file}..."
output = system "../marc-to-argot/exe/mta create -t xml nccu #{file} #{path}/add-#{current_date}.json 2>error.log"

if output == false
  error = File.read("/home/ec2-user/nccu-update-records/error.log")
  file_content = File.read("#{file}")
  subject = "NCCU: Marc-to-argot error"
  message = "#{file} file produced a marc-to-argot error. \n \n Error: \n \n #{error}. \n \n File: \n \n #{file_content}."
  send_email(subject, message)
end  

