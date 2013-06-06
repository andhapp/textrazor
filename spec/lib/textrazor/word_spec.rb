require "spec_helper"

module TextRazor

  describe Word do

    context "#create_from_hash" do

      it "should create a new instance" do
        word_hash = {"position" => 0, "startingPos" => 0, "endingPos" => 3, "stem" => "the",
                     "lemma" => "the", "token" => "The", "partOfSpeech" => "DT"}

        word = Word.create_from_hash(word_hash)

        expect(word.position).to eq(0)
        expect(word.starting_pos).to eq(0)
        expect(word.ending_pos).to eq(3)
        expect(word.stem).to eq("the")
        expect(word.lemma).to eq("the")
        expect(word.token).to eq("The")
        expect(word.part_of_speech).to eq("DT")
      end

    end

  end

end
