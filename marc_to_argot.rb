require './helper.rb'

file = ARGV[0]

puts "Processing #{file}..."
output = system "../marc-to-argot/exe/mta create -t xml nccu #{file} #{Helper::PATH}/add-#{Helper::CURRENT_DATE}.json 2>error.log"

Helper.notify_about_errors(output, subject = "Marc-to-argot", file)

puts "Done!" 

