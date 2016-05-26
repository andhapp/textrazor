require "spec_helper"

module TextRazor

  describe Topic do

    context "#create_from_hash" do
      let(:topic_hash) do
        {
          id: 1,
          label: "Sports",
          wikiLink: "link_to_wiki",
          score: 1.03589,
          wikidataId: "Q042"
        }
      end

      let(:topic) do
        Topic.create_from_hash(topic_hash)
      end

      it "should create a new instance" do
        expect(topic.id).to eq(1)
        expect(topic.label).to eq("Sports")
        expect(topic.wiki_link).to eq("link_to_wiki")
        expect(topic.score).to eq(1.03589)
        expect(topic.wikidata_id).to eq("Q042")
      end

    end

  end

end
