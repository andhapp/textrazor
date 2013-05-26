require "spec_helper"

module TextRazor

  describe Topic do

    context "#initialize" do

      it "should create a new instance" do
        topic = Topic.new(1, "Sports", "link_to_wiki", 1.03589)

        expect(topic.id).to eq(1)
        expect(topic.label).to eq("Sports")
        expect(topic.wiki_link).to eq("link_to_wiki")
        expect(topic.score).to eq(1.03589)
      end

    end

  end

end
