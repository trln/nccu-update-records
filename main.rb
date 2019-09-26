#run once a day
require_relative "./helper.rb"

if File.exist?("#{Helper::PATH}/data/update/update-#{Helper::FILE_TO_UPDATE}.mrc")
  #system "yaz-marcdump -f MARC-8 -t UTF-8 -o marcxml #{Helper::PATH}/data/update/update-#{Helper::FILE_TO_UPDATE}.mrc >#{Helper::PATH}/update/update-#{Helper::FILE_TO_UPDATE}.xml"
  #puts "Converted to MARCXML."

  #if File.exist?("#{Helper::PATH}/data/update/update-#{Helper::FILE_TO_UPDATE}.xml")
    #system "ruby cleanup_and_validate.rb #{Helper::PATH}/data/update/update-#{Helper::FILE_TO_UPDATE}.xml"
    #puts "Clean up Done!"

    #if File.exist?("#{Helper::PATH}/data/update/update-#{Helper::FILE_TO_UPDATE}-clean.xml")
      #system "ruby marc_to_argot.rb #{Helper::PATH}/data/update/update-#{Helper::FILE_TO_UPDATE}-clean.xml"
      system "ruby nccu-update-records/marc_to_argot.rb #{Helper::PATH}/data/update/update-#{Helper::FILE_TO_UPDATE}.mrc"

      puts "MTA Done!"
    
      if File.exist?("#{Helper::PATH}/data/update/add-#{Helper::FILE_TO_UPDATE}.json")
        system "ruby nccu-update-records/ingest.rb #{Helper::PATH}/data/update/add-#{Helper::FILE_TO_UPDATE}.json"
        puts "Ingest Done!"
      end
    #end
  #end  
else
  puts "Nothing to update."      
end

