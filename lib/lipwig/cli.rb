class Lipwig::CLI
  def self.call(command = '', source = '')
    new(command, source).call
  end

  def initialize(command, source)
    @command, @source = command, source
  end

  def call
    case command
    when 'send'
      Lipwig::Sender.call email
    when 'preview'
      Lipwig::Preview.call email
    when 'clear'
      Dir['lipwig-preview-*.html'].each { |file| File.delete file }
    else
      puts "Unknown command #{command}." unless command == 'help'
      puts <<-MESSAGE
Commands are:
  send:    Send the email to the specified recipients.
  preview: Open the HTML for the email in your browser.
  clear:   Remove temporary preview files.

Example Usage:
  $ lipwig send email.markdown
  $ lipwig preview email.markdown

Sending emails requires LIPWIG_POSTMARK_API_KEY to be set. Recipients are
whatever is set in the email's frontmatter, but can be overridden by
LIPWIG_RECIPIENTS.
      MESSAGE
    end
  end

  private

  attr_reader :command, :source

  def email
    @email ||= Lipwig::Parser.call File.read(source)
  end
end
