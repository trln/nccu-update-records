#run this file every hour
require './helper.rb'

if File.exist?("#{Helper::PATH}/update-#{Helper::CURRENT_DATE}.xml")
  system "ruby cleanup_and_validate.rb #{Helper::PATH}/update-#{Helper::CURRENT_DATE}.xml"
  puts "Clean up Done!"

  if File.exist?("#{Helper::PATH}/update-#{Helper::CURRENT_DATE}-clean.xml")
    system "ruby marc_to_argot.rb #{Helper::PATH}/update-#{Helper::CURRENT_DATE}-clean.xml"
    puts "MTA Done!"
    
    if File.exist?("#{Helper::PATH}/add-#{Helper::CURRENT_DATE}.json")
      system "ruby ingest.rb #{Helper::PATH}/add-#{Helper::CURRENT_DATE}.json"
      puts "Ingest Done!"
    end
  end    
end

