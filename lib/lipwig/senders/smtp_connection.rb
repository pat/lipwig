require 'mail'
require 'lipwig/senders/smtp'

class Lipwig::Senders::SMTPConnection < Lipwig::Senders::SMTP
  def call
    connection.start(
      ENV['LIPWIG_SMTP_DOMAIN'],
      ENV['LIPWIG_SMTP_USERNAME'],
      ENV['LIPWIG_SMTP_PASSWORD'],
      :plain
    )

    super

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
      smtp
    end
  end

  def delivery_method
    :smtp_connection
  end

  def delivery_method_options
    {:connection => connection}
  end
end
