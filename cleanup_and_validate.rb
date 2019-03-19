require './helper.rb'
file = ARGV[0]

puts "Processing #{file}..."

output_1 = system "ruby xml_cleanup.rb #{file} > #{Helper::PATH}/update-#{Helper::CURRENT_DATE}-better.xml 2>error.log"

Helper.notify_about_errors(output_1, subject = "XML Cleanup", file)

if output_1 == true
  output_2 = system "xmllint --recover #{Helper::PATH}/update-#{Helper::CURRENT_DATE}-better.xml > #{Helper::PATH}/update-#{Helper::CURRENT_DATE}-clean.xml 2>error.log"
  Helper.notify_about_errors(output_1, subject = "XML Recover", file)
end  

puts "Done!"