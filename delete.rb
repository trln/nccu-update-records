#run once a day
require './helper.rb'

delete_path = "#{Helper::PATH}/delete/delete-#{Helper::FILE_TO_DELETE}.json"

if File.exist?(delete_path)
  output = system "spofford ingest #{delete_path} out>error.log"
  Helper.notify_about_errors(output, subject = "Delete documents error", delete_path)
end