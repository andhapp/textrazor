require 'spec_helper'

module TextRazor

  describe Relation do

    context "#create_from_hash" do
      let(:relation_hash) do
        {
          id: 0,
          wordPositions: [1, 6],
          params: [{
            relation: "SUBJECT",
            wordPositions: [18, 19, 20, 21] 
          }, 
          {
            relation: "OBJECT", 
            wordPositions: [2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
          }]
        }
      end

      let(:relation) do
        Relation.create_from_hash(relation_hash)
      end

      it "should create a new instance" do
        expect(relation.number_of_relation_params).to eq 2
        expect(relation.word_positions).to eq [1, 6]
        expect(relation.relation_params.first).to be_instance_of RelationParam
      end

    end

  end

end
