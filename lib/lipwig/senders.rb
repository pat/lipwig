module Lipwig::Senders
  UnknownSenderError = Class.new(StandardError)

  def self.call(email)
    if ENV['LIPWIG_POSTMARK_API_KEY']
      require 'lipwig/senders/postmark'
      Lipwig::Senders::Postmark.call email
    elsif ENV['LIPWIG_SMTP_CONNECTION']
      require 'lipwig/senders/smtp_connection'
      Lipwig::Senders::SMTPConnection.call email
    elsif ENV['LIPWIG_SMTP_ADDRESS']
      require 'lipwig/senders/smtp'
      Lipwig::Senders::SMTP.call email
    else
      raise UnknownSenderError, "Sending protocol could not be determined"
    end
  end
end

require 'lipwig/senders/abstract'
