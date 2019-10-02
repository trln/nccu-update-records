#run once a day
require_relative "./helper.rb"

delete_path = "#{Helper::PATH}/data/delete/delete-#{Helper::FILE_TO_DELETE}.json"

if File.exist?(delete_path)
  #clean up the array: remove a vertical bar
  array = File.read(delete_path)
  replace = array.gsub(/\|/,"");
  File.open(delete_path, "w") {|file| file.puts replace}
  
  puts "Processing file #{delete_path}"
  output = "curl -v -H'Content-Type: application/json' -H'X-User-Email: genia@trln.org' -H'X-User-Token: sdjSYp8tQ8x-ZNBSHjbj' --data-binary @/home/ec2-user/data/delete/delete-10-01-2019.json https://ingest.discovery.trln.org/ingest/nccu"
  #output = system "spofford ingest #{delete_path} out>#{Helper::PATH}/error.log"
  
  #Helper.notify_about_errors(output, subject = "Delete documents error", delete_path)
else
  puts "Nothing to delete."  
end