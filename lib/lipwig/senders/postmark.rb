require 'postmark'

class Lipwig::Senders::Postmark < Lipwig::Senders::Abstract
  def call
    client.deliver_in_batches(messages).each do |response|
      puts "Delivery To:     #{Array(response[:to]).join(', ')}"
      puts "Delivery Status: #{response[:message]}"
      puts ""
    end
  end

  private

  attr_reader :email

  def client
    @client ||= Postmark::ApiClient.new ENV['LIPWIG_POSTMARK_API_KEY']
  end

  def messages
    recipients.collect do |recipient|
      {
        :from      => from,
        :to        => recipient,
        :subject   => email.subject,
        :html_body => email.body,
        :cc        => email.ccs
      }
    end
  end
end
