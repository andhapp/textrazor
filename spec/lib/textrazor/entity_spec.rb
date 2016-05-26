require "spec_helper"

module TextRazor

  describe Entity do

    context "#create_from_hash" do

      let(:entity) do
        Entity.create_from_hash(entity_hash)
      end

      context "with defined values" do
        let(:entity_hash) do
          {
            "id" => 1,
            "type" => ['Person'],
            "matchingTokens" => [1, 2],
            "entityId" => "Foreign minister",
            "freebaseTypes" => ["government/government_office_or_title"],
            "confidenceScore" => 0.897858,
            "wikiLink" => "http://en.wikipedia.org/wiki/Foreign_minister",
            "matchedText" => "foreign ministers",
            "freebaseId" => "/m/01t_55",
            "relevanceScore" => 0.311479,
            "entityEnglishId" => "Foreign minister",
            "startingPos" => 3,
            "endingPos" => 20,
            "data" => {
              "type" => ['person', 'company']
            },
            "wikidataId" => 'Q7330070'
          }
        end

        it "should create a new instance" do
          expect(entity.id).to eq(1)
          expect(entity.type).to eq(['Person'])
          expect(entity.matching_tokens).to eq([1,2])
          expect(entity.entity_id).to eq("Foreign minister")
          expect(entity.freebase_types).to eq(["government/government_office_or_title"])
          expect(entity.confidence_score).to eq(0.897858)
          expect(entity.wiki_link).to eq("http://en.wikipedia.org/wiki/Foreign_minister")
          expect(entity.matched_text).to eq("foreign ministers")
          expect(entity.freebase_id).to eq("/m/01t_55")
          expect(entity.relevance_score).to eq(0.311479)
          expect(entity.entity_english_id).to eq("Foreign minister")
          expect(entity.starting_pos).to eq(3)
          expect(entity.ending_pos).to eq(20)
          expect(entity.data['type']).to match_array(['person', 'company'])
          expect(entity.wikidata_id).to eq('Q7330070')
        end
      end

      context "with empty values" do

        let(:entity_hash) do
          {
            "id" => 1,
            "startingPos" => 3,
            "endingPos" => 20
          }
        end

        it "should use sensible defaults" do
          expect(entity.type).to eq([])
        end

      end

    end

  end

end
