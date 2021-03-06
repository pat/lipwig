require 'mail'

class Lipwig::Senders::SMTP < Lipwig::Senders::Abstract
  def call
    recipients.each do |recipient|
      mail = Mail.new
      mail.delivery_method delivery_method, delivery_method_options

      mail.content_type = 'text/html; charset=UTF-8'
      mail.from         = from
      mail.to           = recipient
      mail.subject      = email.subject
      mail.body         = email.body
      mail.cc           = email.ccs

      begin
        puts "Delivery To:     #{Array(recipient).join(', ')}"
        mail.deliver!
        puts "Delivery Status: OK", ""
      rescue => error
        puts "Delivery Status: Failed (#{error.message})", ""
      end
    end
  end

  private

  attr_reader :email

  def delivery_method
    :smtp
  end

  def delivery_method_options
    @delivery_method_options ||= {
      :address              => ENV['LIPWIG_SMTP_ADDRESS'],
      :port                 => ENV['LIPWIG_SMTP_PORT'],
      :authentication       => :plain,
      :user_name            => ENV['LIPWIG_SMTP_USERNAME'],
      :password             => ENV['LIPWIG_SMTP_PASSWORD'],
      :domain               => ENV['LIPWIG_SMTP_DOMAIN'],
      :enable_starttls_auto => true
    }
  end
end
