class Lipwig::Parser
  MARKER = /---\s*/

  def self.call(input)
    new(input).call
  end

  def initialize(input)
    @input = input
  end

  def call
    email = Lipwig::Email.new
    email.from       = frontmatter['from']
    email.subject    = frontmatter['subject']
    email.recipients = frontmatter['recipients']
    email.ccs        = Array frontmatter['cc']
    email.body       = html
    email
  end

  private

  attr_reader :input

  def frontmatter
    @frontmatter ||= YAML.load input.split(MARKER).first.strip
  end

  def html
    <<-HTML
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">
    #{ renderer.render(markdown).strip }
  </body>
</html>
    HTML
  end

  def markdown
    @markdown ||= input.split(MARKER).last.strip
  end

  def renderer
    @renderer ||= Redcarpet::Markdown.new Redcarpet::Render::HTML.new
  end
end
