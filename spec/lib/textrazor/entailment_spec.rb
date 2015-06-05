require "spec_helper"

module TextRazor

  describe Entailment do

    context "#create_from_hash" do

      let(:entailment_hash) {
        {
          :id=>2, :wordPositions=>[1], :entailedWords=>["misrepresentation"],
          :entailedTree=>{
            :word=>"misrepresentation", :wordId=>0, :parentRelation=>-1
          },
          :priorScore=>0.00132419, :contextScore=>0.0694058, :score=>0.154246
        }
      }

      it "creates a new instance" do
        entailment = Entailment.create_from_hash(entailment_hash)

        expect(entailment.id).to eq(2)
        expect(entailment.entailed_tree).to eq({
          :word=>"misrepresentation", :wordId=>0, :parentRelation=>-1
        })
        expect(entailment.word_positions).to eq([1])
        expect(entailment.prior_score).to eq(0.00132419)
        expect(entailment.context_score).to eq(0.0694058)
        expect(entailment.score).to eq(0.154246)
      end

    end

  end

end
