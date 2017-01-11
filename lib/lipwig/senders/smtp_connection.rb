require 'mail'

class Lipwig::Senders::SMTPConnection < Lipwig::Senders::Abstract
  def call
    recipients.each do |recipient|
      mail = Mail.new
      mail.delivery_method :smtp_connection, :connection => connection

      mail.content_type = 'text/html; charset=UTF-8'
      mail.from         = from
      mail.to           = recipient
      mail.subject      = email.subject
      mail.body         = email.body

      begin
        puts "Delivery To:     #{Array(recipient).join(', ')}"
        mail.deliver!
        puts "Delivery Status: OK", ""
      rescue => error
        puts "Delivery Status: Failed (#{error.message})", ""
      end
    end

    connection.finish
  end

  private

  attr_reader :email

  def connection
    @connection ||= begin
      smtp = Net::SMTP.new(
        ENV['LIPWIG_SMTP_ADDRESS'], ENV['LIPWIG_SMTP_PORT']
      )
      smtp.enable_starttls_auto

      smtp.start(
        ENV['LIPWIG_SMTP_DOMAIN'],
        ENV['LIPWIG_SMTP_USERNAME'],
        ENV['LIPWIG_SMTP_PASSWORD'],
        :plain
      )
    end
  end
end
