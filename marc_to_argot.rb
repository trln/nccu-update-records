require_relative "./helper.rb"

file = ARGV[0]

#puts "Processing #{file}..."
system "#{Helper::PATH}/marc-to-argot/exe/mta create -t binary nccu #{file} #{Helper::PATH}/data/update/add-#{Helper::FILE_TO_UPDATE}.json"

#Helper.notify_about_errors(output, subject = "Marc-to-argot", file)

#puts "Done!" 

