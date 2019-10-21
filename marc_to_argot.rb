require_relative "./helper.rb"

current_file = ARGV[0]
update = ARGV[1]

puts "Marc-to-argot: #{update} change(s)\n\n"
puts "Processing #{current_file}...\n\n"

system "#{Helper::PATH}/marc-to-argot/exe/mta create -t binary nccu #{ciurrent_file} #{Helper::PATH}/data/update/add-#{update}-#{Helper::FILE_TO_UPDATE}.json"

puts "\n\n"

