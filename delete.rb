#run once a day
require './helper.rb'

delete_path = "#{Helper::PATH}/delete/delete-#{Helper::FILE_TO_DELETE}.json"

if File.exist?(delete_path)
  #clean up the array: remove a vertical bar
  array = File.read(delete_path)
  replace = array.gsub(/\|/,"");
  File.open(delete_path, "w") {|file| file.puts replace}
  
  output = system "spofford ingest #{delete_path} out>error.log"
  Helper.notify_about_errors(output, subject = "Delete documents error", delete_path)
else
	puts "Nothing to delete."  
end