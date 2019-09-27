require './helper.rb'

file = ARGV[0]

puts "Processing #{file}..."

cleanup_output = system "ruby xml_cleanup.rb #{file} > #{Helper::PATH}/data/update/update-#{Helper::FILE_TO_UPDATE}-better.xml 2>error.log"
Helper.notify_about_errors(cleanup_output, subject = "XML Cleanup", file)

if cleanup_output == true
  recovery_output = system "xmllint --recover #{Helper::PATH}/data/update/update-#{Helper::FILE_TO_UPDATE}-better.xml > #{Helper::PATH}/data/update/update-#{Helper::FILE_TO_UPDATE}-clean.xml 2>error.log"
  Helper.notify_about_errors(recovery_output, subject = "XML Recover", file)
end  

puts "Done!"