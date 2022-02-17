#run once a day
require_relative "./helper.rb"

delete_path = "#{Helper::PATH}/data/delete/delete-#{Helper::TIMESTAMP}.json"

if File.exist?(delete_path)
  #clean up the array: remove a vertical bar
  array = File.read(delete_path)
  replace = array.gsub(/\|/,"");
  File.open(delete_path, "w") {|file| file.puts replace}
  
  puts "Processing file #{delete_path}"
  output = system "spofford ingest #{delete_path}"
else
  puts "Nothing to delete."  
end