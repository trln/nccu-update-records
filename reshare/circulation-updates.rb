require_relative ".././helper.rb"

FILE = "#{Helper::PATH}/data/update/circulation-updates-#{Helper::TIMESTAMP}.mrc"
FILE_NAME = "circulation-updates-#{Helper::TIMESTAMP}.mrc"


if File.exist?(FILE)
  system "curl -F 'upload[name]=#{FILE_NAME}' -F 'upload[files][]=@/#{FILE};type=application/marc' -H 'Authorization: Bearer #{ENV['ACCESS_TOKEN']}' https://pod.stanford.edu/organizations/#{ENV['ORG_CODE']}/uploads?stream=#{ENV['STREAM_ID']}"
end
