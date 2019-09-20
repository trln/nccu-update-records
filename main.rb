#run once a day
require './helper.rb'

if File.exist?("#{Helper::PATH}/update/update-#{Helper::FILE_TO_UPDATE}.mrc")
  #system "yaz-marcdump -f MARC-8 -t UTF-8 -o marcxml #{Helper::PATH}/update/update-#{Helper::FILE_TO_UPDATE}.mrc >#{Helper::PATH}/update/update-#{Helper::FILE_TO_UPDATE}.xml"
  #puts "Converted to MARCXML."

  #if File.exist?("#{Helper::PATH}/update/update-#{Helper::FILE_TO_UPDATE}.xml")
    #system "ruby cleanup_and_validate.rb #{Helper::PATH}/update/update-#{Helper::FILE_TO_UPDATE}.xml"
    #puts "Clean up Done!"

    #if File.exist?("#{Helper::PATH}/update/update-#{Helper::FILE_TO_UPDATE}-clean.xml")
      #system "ruby marc_to_argot.rb #{Helper::PATH}/update/update-#{Helper::FILE_TO_UPDATE}-clean.xml"
      system "ruby marc_to_argot.rb #{Helper::PATH}/update/update-#{Helper::FILE_TO_UPDATE}.mrc"

      puts "MTA Done!"
    
      if File.exist?("#{Helper::PATH}/update/add-#{Helper::FILE_TO_UPDATE}.json")
        system "ruby ingest.rb #{Helper::PATH}/update/add-#{Helper::FILE_TO_UPDATE}.json"
        puts "Ingest Done!"
      end
    #end
  #end  
else
  puts "Nothing to update."      
end

