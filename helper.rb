require 'aws-sdk'
require 'mime'    #gem install mime
require 'base64'  #standard library

module Helper
  PATH = "/home/ec2-user"
  FILE_TO_UPDATE = Time.now.strftime("%m-%d-%Y")
  FILE_TO_DELETE = Time.now.strftime("%m-%d-%Y")
  
  def self.send_email(subject, message)
    # This address must be verified with Amazon SES.
    sender = "admin@trln.org"
    sendername = "TRLN Admin"

    # Replace recipient@example.com with a "To" address. If your account 
    # is still in the sandbox, this address must be verified.
    recipient = "evgeniia.kazymova@duke.edu"

    # Specify a configuration set. 
    configsetname = "ConfigSet"
   
    # Replace us-west-2 with the AWS Region you're using for Amazon SES.
    awsregion = "us-east-1-2"

    # The subject line for the email.
    #subject = "Updates"

    # The full path to the file that will be attached to the email.
    attachment = "/home/ec2-user/data/update/update-10-17-2019.mrc"

    # The email body for recipients with non-HTML email clients.  
    textbody = "#{message}"


    # Create a new MIME text object that contains the base64-encoded content of the
    # file that will be attached to the message.
    file = MIME::Application.new(Base64::encode64(open(attachment).read))

    # Specify that the file is a base64-encoded attachment to ensure that the 
    # receiving client handles it correctly. 
    file.transfer_encoding = 'base64'
    file.disposition = 'attachment'

    # Create a MIME Multipart Mixed object. This object will contain the body of the
    # email and the attachment.
    msg_mixed = MIME::Multipart::Mixed.new

    # Create a MIME Multipart Alternative object. This object will contain both the
    # HTML and plain text versions of the email.
    msg_body = MIME::Multipart::Alternative.new

    # Add the plain text and HTML content to the Multipart Alternative part.
    msg_body.add(MIME::Text.new(textbody,'plain'))


    # Add the Multipart Alternative part to the Multipart Mixed part.
    #msg_mixed.add(msg_body)

    # Add the attachment to the Multipart Mixed part.
    msg_mixed.attach(file, 'filename' => attachment)

    # Create a new Mail object that contains the entire Multipart Mixed object. 
    # This object also contains the message headers.
    msg = MIME::Mail.new(msg_mixed)
    msg.to = { recipient => nil }
    msg.from = { sender => sendername }
    msg.subject = subject
    msg.headers.set('X-SES-CONFIGURATION-SET',configsetname)

    # Create a new SES resource and specify a region
    ses = Aws::SES::Client.new(region: awsregion)

    # Try to send the email.
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