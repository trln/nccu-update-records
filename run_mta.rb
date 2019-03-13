require 'logger'

path = "/home/ec2-user/data/update"
current_date = Time.now.strftime("%d-%m-%Y-%H")

file = ARGV[0]

puts "Processing #{file}..."
output = system "../marc-to-argot/exe/mta create -t xml nccu #{file}.xml #{path}/add-#{current_date}.json"

if output == false
  log = Logger.new("/home/ec2-user/log/log-mta-#{current_date}.txt",  "monthly")
  subject = "NCCU: Marc-to-argot error"
  message = "#{file}.xml file produced a mta error"
  log.error message
  send_email(subject, message)
end  

