#run this file every hour
require './helper.rb'

if File.exist?("#{Helper::PATH}/update/update-#{Helper::CURRENT_DATE_TO_UPDATE}.xml")
  system "ruby cleanup_and_validate.rb #{Helper::PATH}/update/update-#{Helper::CURRENT_DATE_TO_UPDATE}.xml"
  puts "Clean up Done!"

  if File.exist?("#{Helper::PATH}/update/update-#{Helper::CURRENT_DATE_TO_UPDATE}-clean.xml")
    system "ruby marc_to_argot.rb #{Helper::PATH}/update/update-#{Helper::CURRENT_DATE_TO_UPDATE}-clean.xml"
    puts "MTA Done!"
    
    if File.exist?("#{Helper::PATH}/update/add-#{Helper::CURRENT_DATE_TO_UPDATE}.json")
      system "ruby ingest.rb #{Helper::PATH}/update/add-#{Helper::CURRENT_DATE_TO_UPDATE}.json"
      puts "Ingest Done!"
    end
  end    
end

