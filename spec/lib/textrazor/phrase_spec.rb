require "spec_helper"

module TextRazor

  describe Phrase do

    context "#create_from_hash" do

      let(:phrase_hash) do
        {"id" => 1, "wordPositions" => [0, 1, 2]}
      end

      let(:words) do
        [
          OpenStruct.new(token: 'Word1'),
          OpenStruct.new(token: 'Word2'),
          OpenStruct.new(token: 'Word3')
        ]
      end

      it "should create a new instance" do
        phrase = Phrase.create_from_hash(phrase_hash, words)
        expect(phrase.id).to eq(1)
      end

    end

  end

end
