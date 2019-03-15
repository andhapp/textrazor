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

  describe "#use_europe_endpoint" do
    it "default value is false" do
      Configuration.new.use_europe_endpoint = false
    end
  end

  describe "#use_europe_endpoint=" do
    it "can set value" do
      config = Configuration.new
      config.use_europe_endpoint = true
      expect(config.use_europe_endpoint).to eq(true)
    end
  end

  describe "#url" do
    it "right default value" do
      config = Configuration.new
      expect(config.url).to eq("https://api.textrazor.com")
    end

    it "right value when not secure" do
      config = Configuration.new
      config.secure = false
      expect(config.url).to eq("http://api.textrazor.com")
    end

    it "right value when Europe endpoint is forced" do
      config = Configuration.new
      config.use_europe_endpoint = true
      expect(config.url).to eq("https://api-eu.textrazor.com")
    end
  end
end
