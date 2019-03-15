#run this file every hour
require './variables.rb'

if File.exist?("#{Variables::PATH}/update-#{Variables::CURRENT_DATE}.xml")
  system "ruby cleanup_and_validate.rb #{Variables::PATH}/update-#{Variables::CURRENT_DATE}.xml"
  puts "Clean up Done!"

  if File.exist?("#{Variables::PATH}/update-#{Variables::CURRENT_DATE}-clean.xml")
    system "ruby run_mta.rb #{Variables::PATH}/update-#{Variables::CURRENT_DATE}-clean.xml"
    puts "MTA Done!"
    
    if File.exist?("#{Variables::PATH}/add-#{Variables::CURRENT_DATE}.json")
      system "ruby ingest.rb #{Variables::PATH}/add-#{Variables::CURRENT_DATE}.json"
      puts "Ingest Done!"
    end
  end    
end

