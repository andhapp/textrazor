require "spec_helper"

module TextRazor

  describe Property do

    context "#create_from_hash" do
      let(:property_hash) do
        {
          id: 1,
          wordPositions: [9, 11, 12],
          propertyPositions: [10]
        }
      end

      let(:property) do
        Property.create_from_hash(property_hash)
      end

      it "should create a new instance" do
        expect(property.id).to eq(1)
        expect(property.word_positions).to eq([9,11,12])
        expect(property.property_positions).to eq([10])
      end

    end

  end

end
