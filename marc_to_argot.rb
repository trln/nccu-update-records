require './helper.rb'

file = ARGV[0]

puts "Processing #{file}..."
output = system "../marc-to-argot/exe/mta create -t xml nccu #{file} #{Helper::PATH}/update/add-#{Helper::FILE_TO_UPDATE}.json 2>error.log"

Helper.notify_about_errors(output, subject = "Marc-to-argot", file)

puts "Done!" 

