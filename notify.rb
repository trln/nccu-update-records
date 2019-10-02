require_relative "./helper.rb"

update_log_path = "#{Helper::PATH}/cronlogs/update_#{Helper::FILE_TO_UPDATE}.log"
delete_log_path = "#{Helper::PATH}/cronlogs/delete_#{Helper::FILE_TO_DELETE}.log"

file_to_update = "#{Helper::PATH}/data/update/add-#{Helper::FILE_TO_UPDATE}.json"
file_to_delete = "#{Helper::PATH}/data/delete/delete-#{Helper::FILE_TO_DELETE}.json"

processes = ["update", "delete"]

for i in processes do
  message = create_message(i)
  Helper.send_email(subject = "NCCU #{i} log", message)
end

def create_message(process)
	if File.exists?("#{process}_log_path")
	  contents = File.read("#{process}_log_path")
	  message = "Below is the NCCU #{process} log: \n\n #{contents}. \n\n If you see any errors in this log, you need to log in to aws via ssh and debug the errors."
    end
end
