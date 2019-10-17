require 'aws-sdk'
require 'mime'    #gem install mime
require 'base64'  #standard library

module Helper
  PATH = "/home/ec2-user"
  FILE_TO_UPDATE = Time.now.strftime("%m-%d-%Y")
  FILE_TO_DELETE = Time.now.strftime("%m-%d-%Y")
  
  def self.send_email(subject, message, attachment)
    sender = "admin@trln.org"
    sendername = "TRLN Admin"
    recipient = "evgeniia.kazymova@duke.edu"

    configsetname = "ConfigSet"
    awsregion = "us-east-1"
  
    textbody = "#{message}"
    
    msg_mixed = MIME::Multipart::Mixed.new
    msg_body = MIME::Multipart::Alternative.new
    msg_body.add(MIME::Text.new(textbody,'plain'))
    msg_mixed.add(msg_body)
    
    if(File.exist?(attachment)) 
      file = MIME::Application.new(Base64::encode64(open(attachment).read))
      file.transfer_encoding = 'base64'
      file.disposition = 'attachment'
      msg_mixed.attach(file, 'filename' => attachment)
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
    # If the message was sent, show the message ID.
    puts "Email sent! Message ID: " + resp[0].to_s
 
    # If the message was not sent, show a message explaining what went wrong.
    rescue Aws::SES::Errors::ServiceError => error
      puts "Email not sent. Error message: #{error}"
    end

#   def self.send_email(subject, message)
#     sender = "admin@trln.org"
#     recipient = "evgeniia.kazymova@duke.edu"
    
#     awsregion = "us-east-1"
#     textbody = "#{message}"
#     encoding = "UTF-8"

#     # Create a new SES resource and specify a region
#     ses = Aws::SES::Client.new(region: awsregion)

#     # Try to send the email.
#     begin

#       # Provide the contents of the email.
#       resp = ses.send_email({
#         destination: {
#           to_addresses: [
#             recipient,
#           ],
#         },
#         message: {
#           body: {
#             text: {
#               charset: encoding,
#               data: textbody,
#             },
#           },
#           subject: {
#             charset: encoding,
#             data: subject,
#           },
#         },
#       source: sender,
#       })
#       puts "Email sent!"

#     # If something goes wrong, display an error message.
#     rescue Aws::SES::Errors::ServiceError => error
#       puts "Email not sent. Error message: #{error}"
#     end
   end  
 end  