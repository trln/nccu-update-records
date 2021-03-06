#run once a day
require_relative "./helper.rb"

["title", "circulation"].each do |update|

    if File.exist?("#{Helper::PATH}/data/update/update-#{update}-#{Helper::FILE_TO_UPDATE}.mrc")
      #system "yaz-marcdump -f MARC-8 -t UTF-8 -o marcxml #{Helper::PATH}/data/update/update-#{update}-#{Helper::FILE_TO_UPDATE}.mrc >#{Helper::PATH}/update/update-#{Helper::FILE_TO_UPDATE}.xml"
      #puts "Converted to MARCXML."

      #if File.exist?("#{Helper::PATH}/data/update/update-#{update}-#{Helper::FILE_TO_UPDATE}.xml")
        #system "ruby cleanup_and_validate.rb #{Helper::PATH}/data/update/update-#{update}-#{Helper::FILE_TO_UPDATE}.xml"
        #puts "Clean up Done!"

        #if File.exist?("#{Helper::PATH}/data/update/update-#{update}-#{Helper::FILE_TO_UPDATE}-clean.xml")
          #system "ruby marc_to_argot.rb #{Helper::PATH}/data/update/update-#{update}-#{Helper::FILE_TO_UPDATE}-clean.xml"
          system "ruby #{Helper::PATH}/nccu-update-records/marc_to_argot.rb #{Helper::PATH}/data/update/update-#{update}-#{Helper::FILE_TO_UPDATE}.mrc #{update}"
        
          if File.exist?("#{Helper::PATH}/data/update/add-#{update}-#{Helper::FILE_TO_UPDATE}.json")
            system "ruby #{Helper::PATH}/nccu-update-records/ingest.rb #{Helper::PATH}/data/update/add-#{update}-#{Helper::FILE_TO_UPDATE}.json"
          end
        #end
      #end
    else
      puts "Nothing to update."          
    end
end    

