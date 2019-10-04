require_relative "./helper.rb"

file = ARGV[0]

puts "Marc-to-argot:\n\n"
puts "Processing #{file}...\n\n"

system "#{Helper::PATH}/marc-to-argot/exe/mta create -t binary nccu #{file} #{Helper::PATH}/data/update/add-#{Helper::FILE_TO_UPDATE}.json"

puts "\n\n"

