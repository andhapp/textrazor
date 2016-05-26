require "spec_helper"

module TextRazor

  describe Category do

    context "#create_from_hash" do
      let(:category_hash) do
        {
          "id":0,
          "classifierId":"textrazor_iab",
          "categoryId":"IAB11",
          "label":"Law, Gov’t & Politics",
          "score":0.809611
        }
      end

      let(:category) do
        Category.create_from_hash(category_hash)
      end

      it "should create a new instance" do
        expect(category.id).to eq(0)
        expect(category.classifier_id).to eq("textrazor_iab")
        expect(category.category_id).to eq("IAB11")
        expect(category.label).to eq("Law, Gov’t & Politics")
        expect(category.score).to eq(0.809611)
      end

    end

  end

end
