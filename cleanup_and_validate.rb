require './helper.rb'
file = ARGV[0]

puts "Processing #{file}..."

cleanup_output = system "ruby xml_cleanup.rb #{file} > #{Helper::PATH}/update-#{Helper::CURRENT_DATE}-better.xml 2>error.log"

Helper.notify_about_errors(cleanup_output, subject = "XML Cleanup", file)

if cleanup_output == true
  recovery_output = system "xmllint --recover #{Helper::PATH}/update-#{Helper::CURRENT_DATE}-better.xml > #{Helper::PATH}/update-#{Helper::CURRENT_DATE}-clean.xml 2>error.log"
  Helper.notify_about_errors(recovery_output, subject = "XML Recover", file)
end  

puts "Done!"