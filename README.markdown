# Lipwig

Lipwig is a small tool for sending bulk emails in a slightly more friendly vibe than BCC'ing everyone.

## Why?

I have a habit of inviting friends to various events and shows, but I don't like putting everyone's email address in the _To_ field (it's not nice to disclose so many peoples' email addresses). I also don't like putting everyone in the _BCC_ field (it's nice to keep couples' email addresses together, and make the email feel at least a little more personal).

So, I'd been writing Ruby scripts to send neatly formatted emails, but Lipwig wraps up that logic and makes it a bit more re-usable.

## Installation

    $ gem install lipwig

Also, you'll need either the `postmark` gem or the `mail` gem, depending on whether you want to send via Postmark's API or by SMTP.

    $ gem install postmark
    # or
    $ gem install mail

Lipwig is known to work with Postmark >= 1.9 and Mail >= 2.6.4.

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

### Sending Configuration

If you're using Postmark's API, then all you need to set is the `LIPWIG_POSTMARK_API_KEY` environment variable.

For SMTP, there's a handful of required environment variables:

* LIPWIG_SMTP_ADDRESS
* LIPWIG_SMTP_PORT
* LIPWIG_SMTP_USERNAME
* LIPWIG_SMTP_PASSWORD
* LIPWIG_SMTP_DOMAIN

If you're using SMTP and sending many emails, it's recommended you use the persistent connection approach if your provider supports it, by setting `LIPWIG_SMTP_CONNECTION=true`.

### Options

You can use `LIPWIG_FROM` for your default _From_ setting - though anything specified in your email file will override this. `LIPWIG_RECIPIENTS`, on the otherhand, will override your email file's recipients - useful for a quick test before you fill up everyone's inboxes.

### Commands

You can review the HTML of the email in your browser (currently built with macOS in mind):

    $ lipwig preview my-email.markdown

You can clear out the generated preview files:

    $ lipwig clear

And you can send the emails:

    $ lipwig send my-email.markdown

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pat/lipwig. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Licence

Copyright (c) 2016, Lipwig is developed and maintained by Pat Allan, and is
released under the open MIT Licence.
