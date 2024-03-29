#run once a day
require_relative "./helper.rb"

Helper::UPDATES.each do |update|

    if File.exist?("#{Helper::PATH}/data/update/#{update}-#{Helper::TIMESTAMP}.mrc")
      #system "yaz-marcdump -f MARC-8 -t UTF-8 -o marcxml #{Helper::PATH}/data/update/#{update}-#{Helper::FILE_TO_UPDATE}.mrc >#{Helper::PATH}/update/update-#{Helper::FILE_TO_UPDATE}.xml"
      #puts "Converted to MARCXML."

      #if File.exist?("#{Helper::PATH}/data/update/update-#{update}-#{Helper::FILE_TO_UPDATE}.xml")
        #system "ruby cleanup_and_validate.rb #{Helper::PATH}/data/update/#{update}-#{Helper::FILE_TO_UPDATE}.xml"
        #puts "Clean up Done!"

        #if File.exist?("#{Helper::PATH}/data/update/#{update}-#{Helper::FILE_TO_UPDATE}-clean.xml")
          #system "ruby marc_to_argot.rb #{Helper::PATH}/data/update/#{update}-#{Helper::FILE_TO_UPDATE}-clean.xml"
          system "ruby #{Helper::PATH}/nccu-update-records/marc_to_argot.rb #{Helper::PATH}/data/update/#{update}-#{Helper::TIMESTAMP}.mrc #{update}"
        
          if File.exist?("#{Helper::PATH}/data/update/add-#{update}-#{Helper::TIMESTAMP}.json")
            system "ruby #{Helper::PATH}/nccu-update-records/ingest.rb #{Helper::PATH}/data/update/add-#{update}-#{Helper::TIMESTAMP}.json"
          end
        #end
      #end
    else
      puts "#{update}: nothing to update."          
    end
end    

