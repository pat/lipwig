class Lipwig::Senders::Abstract
  def self.call(email)
    new(email).call
  end

  def initialize(email)
    @email = email
  end

  def call
    raise NoMethodError, "Sender must implement this call method"
  end

  private

  attr_reader :email

  def from
    email.from || ENV['LIPWIG_FROM']
  end

  def recipients
    return [ENV['LIPWIG_RECIPIENTS']] if ENV['LIPWIG_RECIPIENTS']

    email.recipients
  end
end
