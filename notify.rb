require_relative "./helper.rb"

UPDATE_LOG_PATH = "#{Helper::PATH}/cronlogs/update_#{Helper::FILE_TO_UPDATE}.log"
DELETE_LOG_PATH = "#{Helper::PATH}/cronlogs/delete_#{Helper::FILE_TO_DELETE}.log"

processes = {"update" => UPDATE_LOG_PATH, "delete" => DELETE_LOG_PATH}

def create_message(process, path)
	if File.exists?(path)
	  contents = File.read(path)
	  return "This email contains the NCCU #{process} log from #{path} file.\n\n If you see any errors in this log, you need to log in to aws via ssh and debug the errors.\n\n Here is the log: \n\n#{contents}"
    end
end

processes.each do |key, value|
  message = create_message(key, value)
  case key
    when "update"
      attachments = ["#{Helper::PATH}/data/update/add-title-#{Helper::FILE_TO_UPDATE}.json", 
                     "#{Helper::PATH}/data/update/update-title-#{Helper::FILE_TO_UPDATE}.mrc",
                     "#{Helper::PATH}/data/update/add-circulation-#{Helper::FILE_TO_UPDATE}.json", 
                     "#{Helper::PATH}/data/update/update-circulation-#{Helper::FILE_TO_UPDATE}.mrc"]
    when "delete"
      attachments = ["#{Helper::PATH}/data/delete/delete-#{Helper::FILE_TO_DELETE}.json"]
  end
  Helper.send_email(subject = "NCCU #{key} log", message, attachments)
end

