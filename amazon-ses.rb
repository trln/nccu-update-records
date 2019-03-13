require 'aws-sdk'

def send_email(subject, error_message)
  sender = "admin@trln.org"
  recipient = "genia@trln.org"

  # Specify a configuration set. If you do not want to use a configuration
  # set, comment the following variable and the 
  # configuration_set_name: configsetname argument below. 
  #configsetname = "ConfigSet"
    
  awsregion = "us-east-2"
  #subject = "Marc to Argot or Spofford Errors"
 
  textbody = "This email was sent to notify that #{error_message}. You need to log in to aws console via ssh and manually debug the error."

  # Specify the text encoding scheme.
  encoding = "UTF-8"

  # Create a new SES resource and specify a region
  ses = Aws::SES::Client.new(region: awsregion)

  # Try to send the email.
  begin

    # Provide the contents of the email.
    resp = ses.send_email({
      destination: {
        to_addresses: [
          recipient,
        ],
      },
      message: {
        body: {
          text: {
            charset: encoding,
            data: textbody,
          },
        },
        subject: {
          charset: encoding,
          data: subject,
        },
      },
    source: sender,
    # Comment or remove the following line if you are not using 
    # a configuration set
    #configuration_set_name: configsetname,
    })
    puts "Email sent!"

  # If something goes wrong, display an error message.
  rescue Aws::SES::Errors::ServiceError => error
    puts "Email not sent. Error message: #{error}"

  end
end  