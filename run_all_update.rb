#run this file every hour
require 'variables'

if File.exist?("#{VARIABLES::PATH}/update-#{VARIABLES::CURRENT_DATE}.xml")
  system "ruby cleanup_and_validate.rb #{VARIABLES::PATH}/update-#{VARIABLES::CURRENT_DATE}.xml"
  puts "Clean up Done!"

  if File.exist?("#{VARIABLES::PATH}/update-#{VARIABLES::CURRENT_DATE}-clean.xml")
    system "ruby run_mta.rb #{VARIABLES::PATH}/update-#{VARIABLES::CURRENT_DATE}-clean.xml"
    puts "MTA Done!"
    
    if File.exist?("#{VARIABLES::PATH}/add-#{VARIABLES::CURRENT_DATE}.json")
      system "ruby ingest.rb #{VARIABLES::PATH}/add-#{VARIABLES::CURRENT_DATE}.json"
      puts "Ingest Done!"
    end
  end    
end

