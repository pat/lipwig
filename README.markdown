# Lipwig

Lipwig is a small tool that for sending bulk emails in a slightly more friendly vibe than BCC'ing everyone.

## Why?

I have a habit of inviting friends to various events and shows, but I don't like putting everyone's email address in the _To_ field (it's not nice to disclose so many peoples' email addresses). I also don't like putting everyone in the _BCC_ field (it's nice to keep couples' email addresses together, and make the email feel at least a little more personal).

So, I'd been writing Ruby scripts to send neatly formatted emails, but Lipwig wraps up that logic and makes it a bit more re-usable.

It currently uses Postmark's API, because that's what I use. I'm open to patches that allow for SMTP settings or other provider APIs as well.

## Installation

    $ gem install lipwig

## Usage

Similar to Jekyll, Lipwig expects email files to be a mixture of YAML and Markdown. Here's an example:

    from: "Pat Allan <pat@obfuscated.email.com>"
    subject: "Party time"
    recipients:
     - "rey@obfuscated.email.com",
     - - "finn@obfuscated.email.com"
       - "poe@obfuscated.email.com"
     - "Kylo Ren <ben@obfuscated.email.com>"
    ---
    Hi everyone,

    It's time for a **party**. How about next week? Shall I cook pancakes?

As you can see, the recipients value expects an array, and it can contain arrays to send a single email to more than one person. Everything that follows after the `---` is Markdown, and will be rendered as HTML in the resulting email.

### Options

The environment variable `LIPWIG_POSTMARK_API_KEY` is expected to be set with your API key. You can use `LIPWIG_FROM` for your default _From_ setting - though anything specified in your email file will override this. `LIPWIG_RECIPIENTS`, on the otherhand, will override your email file's recipients - useful for a quick test before you fill up everyone's inboxes.

### Commands

You can review the HTML of the email in your browser (currently built with macOS in mind):

    $ lipwig preview my-email.markdown

You can clear out the generated preview files:

    $ lipwig clear

And you can send the emails:

    $ lipwig send my-email.markdown

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/lipwig. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Licence

Copyright (c) 2016, Lipwig is developed and maintained by Pat Allan, and is
released under the open MIT Licence.
