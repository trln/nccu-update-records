require_relative "./helper.rb"

current_file = ARGV[0]
update = ARGV[1]

puts "============================================"
puts "\n\nMarc-to-argot: #{update} change(s)\n\n"
puts "Processing #{current_file}...\n\n"

system "#{Helper::PATH}/marc-to-argot/exe/mta create -t binary nccu #{current_file} #{Helper::PATH}/data/update/add-#{update}-#{Helper::TIMESTAMP}.json"

puts "\n\n"

