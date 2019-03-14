require "spec_helper"

module TextRazor

  describe Dictionary do

    let(:dictionary) do
      Dictionary.create_from_hash(dictionary_hash)
    end

    let(:dictionary_hash) do
      {
        "id" => "some-dictionary",
        "matchType" => "TOKEN",
        "caseInsensitive" => true,
        "language" => "eng"
      }
    end

    context "#create_from_hash" do

      it "should create a new instance" do
        expect(dictionary.id).to eq("some-dictionary")
        expect(dictionary.match_type).to eq("TOKEN")
        expect(dictionary.case_insensitive).to be(true)
        expect(dictionary.language).to eq("eng")
      end
    end


    context "#to_h" do

      it "should have the right values" do
        expect(dictionary.to_h).to eq(
          "matchType" => "TOKEN",
          "caseInsensitive" => true,
          "language" => "eng"
        )
      end

      context "with default values" do

        let(:dictionary_hash) do
          {
            "id" => "some-dictionary"
          }
        end

        it "should not add them" do
          expect(dictionary.to_h).to eq({})
        end
      end
    end

    context "#valid?" do

      context "when it is valid" do

        it "should return true" do
          expect(dictionary.valid?).to be true
        end

      end

      context "when it is not valid" do
        let(:dictionary_hash) do
          {}
        end

        it "should return false" do
          expect(dictionary.valid?).to be false
        end
      end
    end

  end
end
