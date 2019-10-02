require_relative "./helper.rb"

update_log_path = "#{Helper::PATH}/cronlogs/updates_#{Helper::FILE_TO_UPDATE}.log"
delete_log_path = "#{Helper::PATH}/cronlogs/deletes_#{Helper::FILE_TO_DELETE}.log"

file_to_update = "#{Helper::PATH}/data/update/add-#{Helper::FILE_TO_UPDATE}.json"
file_to_delete = "#{Helper::PATH}/data/update/delete-#{Helper::FILE_TO_DELETE}.json"

if File.exist?(update_log_path)
	contents = File.read(update_log_path)
	Helper.notify_about_errors(contents, subject = "updates", file_to_update)
end

if File.exist?(delete_log_path)
	contents = File.read(delete_log_path)
	Helper.notify_about_errors(contents, subject = "deletes", file_to_delete)
end