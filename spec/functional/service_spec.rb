require 'spec_helper'

describe 'Functional spec', functional: true do
  let(:api_key) do
    ENV["TEXTRAZOR_API_KEY"] or raise 'Please specify a TEXTRAZOR_API_KEY in your local environment to run this'
  end

  let(:client) do
    TextRazor::Client.new(api_key)
  end

  let(:text) do
    t = <<TEXT
Barclays misled shareholders and the public about one of the biggest investments in the bank's history, a BBC Panorama investigation has found.
The bank announced in 2008 that Manchester City owner Sheikh Mansour had agreed to invest more than £3bn.
But the BBC found that the money, which helped Barclays avoid a bailout by British taxpayers, actually came from the Abu Dhabi government.
Barclays said the mistake in its accounts was "a drafting error".
Unlike RBS and Lloyds TSB, Barclays narrowly avoided having to request a government bailout late in 2008 after it was rescued by £7bn worth of new investment, most of which came from the gulf states of Qatar and Abu Dhabi.
Half of the cash was supposed to be coming from Sheikh Mansour.
But Barclays has admitted it was told the investor might change shortly before shareholders voted to approve the deal on 24 November 2008.
But instead of telling shareholders, the bank remained silent until the change of investor was confirmed a few hours later.
TEXT
  end

  it 'returns a response' do
    expect(client.analyse(text)).to be_ok
  end
end

