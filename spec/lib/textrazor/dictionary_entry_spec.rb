require "spec_helper"

module TextRazor

  describe DictionaryEntry do

    let(:dictionary_entry) do
      DictionaryEntry.create_from_hash(dictionary_entry_hash)
    end

    let(:dictionary_entry_hash) do
      {
        "id" => "some-dictionary-entry",
        "text" => "some text",
        "data" => { "key" => ["value1", "value2"] }
      }
    end

    context "#create_from_hash" do

      it "should create a new instance" do
        expect(dictionary_entry.id).to eq("some-dictionary-entry")
        expect(dictionary_entry.text).to eq("some text")
        expect(dictionary_entry.data).to eq("key" => ["value1", "value2"])
      end
    end


    context "#to_h" do

      it "should have the right values" do
        expect(dictionary_entry.to_h).to eq(dictionary_entry_hash)
      end

      context "with default values" do

        let(:dictionary_entry_hash) do
          {
            "text" => "some text"
          }
        end

        it "should not add them" do
          expect(dictionary_entry.to_h).to eq("text" => "some text")
        end
      end
    end

    context "#valid?" do

      context "when it is valid" do

        it "should return true" do
          expect(dictionary_entry.valid?).to be true
        end

      end

      context "when it is not valid" do
        let(:dictionary_entry_hash) do
          {}
        end

        it "should return false" do
          expect(dictionary_entry.valid?).to be false
        end
      end
    end

  end
end
