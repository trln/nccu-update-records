require 'aws-sdk'

def send_email(subject, error_message)
  sender = "admin@trln.org"
  recipient = "genia@trln.org"
    
  awsregion = "us-east-1"
  textbody = "This email was sent to notify that #{error_message}. You need to log in to aws console via ssh and manually debug the error."
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
    })
    puts "Email sent!"

  # If something goes wrong, display an error message.
  rescue Aws::SES::Errors::ServiceError => error
    puts "Email not sent. Error message: #{error}"

  end
end  