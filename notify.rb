require_relative "./helper.rb"

UPDATE_LOG_PATH = "#{Helper::PATH}/cronlogs/update_#{Helper::FILE_TO_UPDATE}.log"
DELETE_LOG_PATH = "#{Helper::PATH}/cronlogs/delete_#{Helper::FILE_TO_DELETE}.log"

file_to_update = "#{Helper::PATH}/data/update/add-#{Helper::FILE_TO_UPDATE}.json"
file_to_delete = "#{Helper::PATH}/data/delete/delete-#{Helper::FILE_TO_DELETE}.json"

processes = Hash.new["update" => UPDATE_LOG_PATH, "delete" => DELETE_LOG_PATH]

def create_message(process, path)
	if File.exists?(path)
	  contents = File.read(path)
	  return "Below is the NCCU #{process} log: \n\n #{contents}. \n\n If you see any errors in this log, you need to log in to aws via ssh and debug the errors."
    end
end


processes.each_key do |key, value|
  puts "Key: #{key}"
  message = create_message(key, value)
  Helper.send_email(subject = "NCCU #{key} log", message)
end
for i in processes do
  
end

