class Lipwig::Preview
  def self.call(email)
    new(email).call
  end

  def initialize(email)
    @email = email
  end

  def call
    File.write filename, email.body

    `open #{filename}`
  end

  private

  attr_reader :email

  def filename
    @filename ||= "#{Dir.pwd}/lipwig-preview-#{Time.now.to_i}.html"
  end
end
