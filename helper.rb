require 'aws-sdk'

module Helper
  PATH = "/home/ec2-user"
  FILE_TO_UPDATE = Time.now.strftime("%m-%d-%Y")
  FILE_TO_DELETE = Time.now.strftime("%m-%d-%Y")

  def self.send_email(subject, message)
    sender = "admin@trln.org"
    recipient = "evgeniia.kazymova@duke.edu"
    
    awsregion = "us-east-1"
    textbody = "#{message}"
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
      puts "Email with the error sent!"

    # If something goes wrong, display an error message.
    rescue Aws::SES::Errors::ServiceError => error
      puts "Email not sent. Error message: #{error}"
    end
  end  
end  