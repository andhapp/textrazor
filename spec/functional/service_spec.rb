require 'spec_helper'

describe 'Functional spec', functional: true do

  it 'should return response' do
    api_key = ENV["TEXTRAZOR_API_KEY"] 
    client = TextRazor::Client.new(api_key)

    text_to_be_analysed = <<TEXT
Barclays misled shareholders and the public about one of the biggest investments in the bank's history, a BBC Panorama investigation has found.
The bank announced in 2008 that Manchester City owner Sheikh Mansour had agreed to invest more than £3bn.
But the BBC found that the money, which helped Barclays avoid a bailout by British taxpayers, actually came from the Abu Dhabi government.
Barclays said the mistake in its accounts was "a drafting error".
Unlike RBS and Lloyds TSB, Barclays narrowly avoided having to request a government bailout late in 2008 after it was rescued by £7bn worth of new investment, most of which came from the gulf states of Qatar and Abu Dhabi.
Half of the cash was supposed to be coming from Sheikh Mansour.
But Barclays has admitted it was told the investor might change shortly before shareholders voted to approve the deal on 24 November 2008.
But instead of telling shareholders, the bank remained silent until the change of investor was confirmed a few hours later.

The bank said it subsequently provided "appropriate disclosure" in three prospectuses that were issued the following day.
But the disclosure was buried deep in the small print and said that Sheikh Mansour "has arranged for his investment…to be funded by an Abu Dhabi governmental investment vehicle, which will become the indirect shareholder".
Barclays still used the phrase "his investment", even though it knew Sheikh Mansour was not actually investing in the bank at the time.
The bank continued to mislead shareholders in its annual reports of 2008 and 2009, both of which identified Sheikh Mansour as the investor
Barclays said the mistake in its accounts was "simply a drafting error" and that the information provided in the prospectuses was "entirely appropriate in all the circumstances".
The bank also said: "The shareholders meeting had already taken place and there was therefore no need to issue press releases or additional formal communications to shareholders/other market participants."

Professor Alistair Milne, an expert on financial regulation in the City, said banks are expected to release accurate information about major deals.
"Any discrepancy of that kind is serious because it raises questions in the minds of investors. Every bank is well aware the annual report is a critical document and a huge amount of time and attention is put in to trying to get all the details correct."
The Abu Dhabi government investment vehicle that provided the funding, International Petroleum Investment Company (IPIC), was not mentioned in any Barclays' announcements until six months after the deal.

The chairman of IPIC is Sheikh Mansour. Although the Sheikh did not invest any of his own money in Barclays at the time, a company he controlled was initially issued warrants to buy 758 million shares in the bank.
The warrants gave the owner a valuable option to buy the shares at a fixed price at any point over the following five years.
If Sheikh Mansour profited personally, then Barclays may have breached anti-corruption laws aimed at preventing payments to government officials.
Jeremy Carver, a lawyer for Transparency International, said Barclays may be at fault if government officials benefitted from the deal.
"You have to worry not because Sheikh Mansour may or may not be doing something wrong, you have to worry because you may be doing something wrong as a bank.
"You may be committing a crime, you may be paying a bribe if you have not got it straight as to which capacity the person you are dealing with is acting."

Barclays issued the warrants to a Jersey company called PCP Gulf Invest 3, which represented the beneficial interests of Sheikh Mansour.
Control of the company was then transferred from the Sheikh to IPIC, then from IPIC to an Abu Dhabi official and then eventually back to Sheikh Mansour.
It is impossible to tell who benefited from the warrants, because all of these transactions took place offshore.
However, the 758 million shares associated with the warrants were bought at significantly below the market price and they now belong to Sheikh Mansour.
Barclays said the change in ownership of the offshore company had no bearing on the transaction or required approvals.
The bank said in a statement that it had "repeatedly demonstrated to Panorama why the allegations which have been put to us are not justified".
"The Board of Barclays took the decision on capital raising in 2008 on the basis of the best interest of shareholder and its other stakeholders, including UK taxpayers," it said.
"Barclays performance relative to other UK banks which accepted government funding, especially on key measures such as lending growth, demonstrates unequivocally that it was the correct decision for Barclays, its shareholders, its customers and clients, as well as the UK."
Neither Sheikh Mansour nor IPIC responded to questions raised by Panorama.
In August last year, the UK's Serious Fraud Office said it had started an investigation into commercial arrangements between the bank and Qatar Holding LLC, part of sovereign wealth fund Qatar Investment Authority.
TEXT

    response = client.analyse(text_to_be_analysed)

    puts response
  end
end

