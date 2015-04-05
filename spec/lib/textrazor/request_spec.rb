require 'spec_helper'

module TextRazor

  describe Request do

    describe ".url" do
      after :each do
        TextRazor.reset
      end

      let(:url) do
        TextRazor::Request.url
      end

      context "with the config 'secure' set to false" do
        before :each do
          TextRazor.configure do |config|
            config.secure = false
          end
        end

        it "returns the unsecured URL" do
          expect(url).to eq 'http://api.textrazor.com/'
        end
      end

      context "with the config 'secure' set to true" do
        before :each do
          TextRazor.configure do |config|
            config.secure = true
          end
        end

        it "returns the unsecured URL" do
          expect(url).to eq 'https://api.textrazor.com/'
        end
      end
    end

    context ".post" do

      context "default options" do

        it "should make correct calls" do
          options = {api_key: 'api_key', extractors: %w(entities topics words dependency-trees relations entailments)}

          expect(::RestClient).to receive(:post).
            with("https://api.textrazor.com/", { "text" => 'text', "apiKey" => 'api_key',
            "extractors" => "entities,topics,words,dependency-trees,relations,entailments" }, accept_encoding: 'gzip')

          Request.post('text', options)
        end

      end

      context "custom options" do

        it "should make correct calls" do
          options = {api_key: 'api_key', extractors: %w(entities topics words), cleanup_mode: 'raw',
                     cleanup_return_cleaned: true, cleanup_return_raw: true, language: 'fre', 
                     filter_dbpedia_types: %w(type1), filter_freebase_types: %w(type2), allow_overlap: false,
                     enrichment_queries: 'queries'}

          expect(::RestClient).to receive(:post).
            with("https://api.textrazor.com/", { "text" => 'text', "apiKey" => 'api_key', "extractors" => "entities,topics,words",
            "cleanup.mode" => "raw", "cleanup.returnCleaned" => true, "cleanup.returnRaw" => true, "languageOverride" => 'fre',
            "entities.filterDbpediaTypes" => "type1", "entities.filterFreebaseTypes" => "type2" , "entities.allowOverlap" => false,
            "entities.enrichmentQueries" => "queries"},
             accept_encoding: 'gzip')

          Request.post('text', options)
        end

      end

    end

  end

end
