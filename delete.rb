#run once a day
require_relative "./helper.rb"

delete_path = "#{Helper::PATH}/data/delete/delete-#{Helper::FILE_TO_DELETE}.json"

if File.exist?(delete_path)
  #clean up the array: remove a vertical bar
  array = File.read(delete_path)
  replace = array.gsub(/\|/,"");
  File.open(delete_path, "w") {|file| file.puts replace}
  
  output = system "spofford ingest #{delete_path} out>error.log"
  puts "Processing file #{delete_path}"
  Helper.notify_about_errors(output, subject = "Delete documents error", delete_path)
else
  puts "Nothing to delete."  
end