require 'spec_helper'

module TextRazor

  describe RelationParam do

    context "#create_from_hash" do
      let(:relation_param_hash) do
        {
          relation: "SUBJECT",
          wordPositions: [18, 19, 20, 21]
        }
      end

      let(:relation_param) do
        RelationParam.create_from_hash(relation_param_hash)
      end

      it "should create a new instance" do
        expect(relation_param.relation).to eq 'SUBJECT'
        expect(relation_param.word_positions).to eq [18, 19, 20, 21]
      end

    end

  end

end

