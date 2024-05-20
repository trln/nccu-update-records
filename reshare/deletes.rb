require_relative ".././helper.rb"

FILE = "#{Helper::PATH}/data/delete/delete-#{Helper::TIMESTAMP}.json"
DELETE_FILE_NAME_RESHARE = "delete-#{Helper::TIMESTAMP}.del"
DELETE_PATH_RESHARE = "#{Helper::PATH}/data/delete/delete-#{Helper::TIMESTAMP}.del"


if File.exist?(FILE)
  file_content = File.read(FILE)
  replace = file_content.gsub("NCCU", "")
                      .gsub("[", "")
                      .gsub("]", "")
                      .gsub(",", "\n")
                      .gsub('"', "")
  File.open(DELETE_PATH_RESHARE, "w") { |file| file.puts replace }
 
  if File.exist?(DELETE_PATH_RESHARE)
    system "curl -F 'upload[name]=#{DELETE_FILE_NAME_RESHARE}' -F 'upload[files][]=@/#{DELETE_PATH_RESHARE};type=text/plain' -H 'Authorization: Bearer #{ENV['ACCESS_TOKEN']}' https://pod.stanford.edu/organizations/#{ENV['ORG_CODE']}/uploads?stream=#{ENV['STREAM_ID']}"
  end
end
