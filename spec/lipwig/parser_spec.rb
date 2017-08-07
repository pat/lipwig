require 'spec_helper'

describe Lipwig::Parser do
  let(:subject) do
    described_class.call <<-MIXED
from: "GNU Terry Pratchett <gnu@pratchett.test>"
subject: "Going Postal"
recipients:
  - vetinari@pratchett.test
  - - moist@pratchett.test
    - spike@pratchett.test
cc: "Drumknott <drumknott@pratchett.test>"
---
What kind of man would put a known criminal in charge of a major branch of government? Apart from, say, the average voter.
    MIXED
  end

  it 'reads the from setting' do
    expect(subject.from).to eq('GNU Terry Pratchett <gnu@pratchett.test>')
  end

  it 'reads the subject setting' do
    expect(subject.subject).to eq('Going Postal')
  end

  it 'builds a list of recipients' do
    expect(subject.recipients).to eq([
      'vetinari@pratchett.test',
      ['moist@pratchett.test', 'spike@pratchett.test']
    ])
  end

  it 'reads the CCs' do
    expect(subject.ccs).to eq(['Drumknott <drumknott@pratchett.test>'])
  end

  it 'parses the message body' do
    expect(subject.body).to eq(<<-HTML)
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">
    <p>What kind of man would put a known criminal in charge of a major branch of government? Apart from, say, the average voter.</p>
  </body>
</html>
    HTML
  end
end
