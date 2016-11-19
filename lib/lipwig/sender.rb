class Lipwig::Sender
  def self.call(email)
    new(email).call
  end

  def initialize(email)
    @email = email
  end

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

  def from
    email.from || ENV['LIPWIG_FROM']
  end

  def messages
    recipients.collect do |recipient|
      {
        :from      => from,
        :to        => recipient,
        :subject   => email.subject,
        :html_body => email.body
      }
    end
  end

  def recipients
    return [ENV['LIPWIG_RECIPIENTS']] if ENV['LIPWIG_RECIPIENTS']

    email.recipients
  end
end
