require_relative ".././helper.rb"

CIRCULATION_RESHARE_LOG_PATH = "#{Helper::PATH}/cronlogs/reshare_circulation_updates_#{Helper::TIMESTAMP}.log"
DELETE_RESHARE_LOG_PATH = "#{Helper::PATH}/cronlogs/reshare_deletes_#{Helper::TIMESTAMP}.log"
NEW_TITLES_RESHARE_LOG_PATH = "#{Helper::PATH}/cronlogs/reshare_new_title_updates_#{Helper::TIMESTAMP}.log"

files = [CIRCULATION_RESHARE_LOG_PATH, DELETE_RESHARE_LOG_PATH, NEW_TITLES_RESHARE_LOG_PATH]
all_files_exist = true

files.each do |file|
  if !File.exists?(file)
    all_files_exist = false
  end
end

if all_files_exist == true
  message = "The Reshare updates are completed. Find the latest  updates here: https://pod.stanford.edu/organizations/nccu/streams/2023-02-20-production"
  Helper.send_email(subject = "Reshare updates", message, attachments=[])
end
