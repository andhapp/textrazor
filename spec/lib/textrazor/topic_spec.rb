require "spec_helper"

module TextRazor

  describe Topic do

    context "#create_from_hash" do

      it "should create a new instance" do
        topic_hash = {
          :id => 1, 
          :label => "Sports", 
          :wikiLink => "link_to_wiki", 
          :score => 1.03589
        }

        topic = Topic.create_from_hash(topic_hash)

        expect(topic.id).to eq(1)
        expect(topic.label).to eq("Sports")
        expect(topic.wiki_link).to eq("link_to_wiki")
        expect(topic.score).to eq(1.03589)
      end

    end

  end

end
