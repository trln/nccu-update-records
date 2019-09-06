#run every hour
require './helper.rb'

if File.exist?("#{Helper::PATH}/update/update-#{Helper::FILE_TO_UPDATE}.mrc")
  #system "ruby cleanup_and_validate.rb #{Helper::PATH}/update/update-#{Helper::FILE_TO_UPDATE}.xml"
  #puts "Clean up Done!"

  #if File.exist?("#{Helper::PATH}/update/update-#{Helper::FILE_TO_UPDATE}-clean.xml")
    system "ruby marc_to_argot.rb #{Helper::PATH}/update/update-#{Helper::FILE_TO_UPDATE}-clean.xml"
    puts "MTA Done!"
    
    if File.exist?("#{Helper::PATH}/update/add-#{Helper::FILE_TO_UPDATE}.json")
      system "ruby ingest.rb #{Helper::PATH}/update/add-#{Helper::FILE_TO_UPDATE}.json"
      puts "Ingest Done!"
    end
  end
else
  puts "Nothing to update."      
end

