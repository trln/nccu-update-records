require 'aws-sdk'

module Helper
  PATH = "/home/ec2-user/data/update"
  CURRENT_DATE = Time.now.strftime("%d-%m-%Y-%H")

  def self.notify_about_errors(output, app, file)
    if output == false
      error = File.read("/home/ec2-user/nccu-update-records/error.log")
      subject = "NCCU: #{app} error"
      message = "#{file} file produced a/an #{app} error: \n \n \n \n Error: #{error}."
      send_email(subject, message)
    end
  end

  def self.send_email(subject, error_message)
    sender = "admin@trln.org"
    recipient = "genia@trln.org"
    
    awsregion = "us-east-1"
    textbody = "This email was sent to notify that #{error_message}. \n \n \n \n Perhaps you need to log in to aws console via ssh and manually debug the error."
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
end  