require "spec_helper"

module TextRazor
  describe Configuration do
    describe "#secure" do
      it "default value is true" do
        Configuration.new.secure = true
      end
    end

    describe "#secure=" do
      it "can set value" do
        config = Configuration.new
        config.secure = false
        expect(config.secure).to eq(false)
      end
    end
  end
end
