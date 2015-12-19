require "spec_helper"

module TextRazor

  describe Sentence do

    context "#create_from_hash" do
      let(:sentence_hash) do
        {
          :position=>0,
          :words=>
           [{
             :position=>0,
             :startingPos=>0,
             :endingPos=>8,
             :stem=>"barclay",
             :lemma=>"barclay",
             :token=>"Barclays",
             :partOfSpeech=>"NNP",
             :parentPosition=>1,
             :relationToParent=>"nsubj"
           }]
        }
      end

      let(:sentence) do
        Sentence.create_from_hash(sentence_hash)
      end

      it "should create a new instance" do
        expect(sentence.position).to eq(0)
        expect(sentence.number_of_words).to eq(1)
        expect(sentence.words.first).to be_instance_of(Word)
      end

    end

  end

end

