require 'aws-sdk'
require 'mime'    #gem install mime
require 'base64'  #standard library

module Helper
  PATH = "/home/ec2-user"
  FILE_TO_UPDATE = Time.now.strftime("%m-%d-%Y")
  FILE_TO_DELETE = Time.now.strftime("%m-%d-%Y")
  
  def self.send_email(subject, message, attachments)
    sender = "admin@trln.org"
    sendername = "TRLN Admin"
    recipient = "evgeniia.kazymova@duke.edu, admin@trln.org"

    configsetname = "ConfigSet"
    awsregion = "us-east-1"
  
    textbody = "#{message}"
    
    msg_mixed = MIME::Multipart::Mixed.new
    msg_body = MIME::Multipart::Alternative.new
    msg_body.add(MIME::Text.new(textbody,'plain'))
    msg_mixed.add(msg_body)
    
    attachments.each do |attachment|
      if(File.exist?(attachment)) 
        file = MIME::Application.new(Base64::encode64(open(attachment).read))
        file.transfer_encoding = 'base64'
        file.disposition = 'attachment' + attachment
        msg_mixed.attach(file, 'filename' => attachment)
      end
    end  

    msg = MIME::Mail.new(msg_mixed)
    msg.to = { recipient => nil }
    msg.from = { sender => sendername }
    msg.subject = subject
    msg.headers.set('X-SES-CONFIGURATION-SET',configsetname)

    ses = Aws::SES::Client.new(region: awsregion)

    begin
 
    # Provide the contents of the email.
    resp = ses.send_raw_email({
      raw_message: {
        data: msg.to_s
      }
    })
 
    # If the message was not sent, show a message explaining what went wrong.
    rescue Aws::SES::Errors::ServiceError => error
      puts "Email not sent. Error message: #{error}"
    end
    
   end  
 end  