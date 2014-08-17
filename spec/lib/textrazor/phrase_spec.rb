require "spec_helper"

module TextRazor

  describe Phrase do

    context "#create_from_hash" do

      it "should create a new instance" do
        phrase_hash = {"id" => 1, "wordPositions" => [0, 1, 2]}
        words       = [
          OpenStruct.new(token: 'Word1'),
          OpenStruct.new(token: 'Word2'),
          OpenStruct.new(token: 'Word3')
        ]

        phrase = Phrase.create_from_hash(phrase_hash, words)

        expect(phrase.id).to eq(1)
      end

    end

  end

end
