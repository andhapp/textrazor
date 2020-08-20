require 'spec_helper'

module TextRazor

  describe Request do

    context ".post" do

      context "default options" do

        it "should make correct calls" do
          options = {api_key: 'api_key', extractors: %w(entities topics words dependency-trees relations entailments)}

          expect(::RestClient).to receive(:post).
            with("https://api.textrazor.com", { "text" => 'text', "apiKey" => 'api_key',
            "extractors" => "entities,topics,words,dependency-trees,relations,entailments" })

          Request.post('text', options)
        end

      end

      context "custom options" do

        it "should make correct calls" do
          options = {api_key: 'api_key', extractors: %w(entities topics words), cleanup_mode: 'raw',
                     cleanup_return_cleaned: true, cleanup_return_raw: true, language: 'fre',
                     filter_dbpedia_types: %w(type1), filter_freebase_types: %w(type2), allow_overlap: false,
                     enrichment_queries: 'queries', classifiers: 'textrazor_iab'}

          expect(::RestClient).to receive(:post).
            with("https://api.textrazor.com", { "text" => 'text', "apiKey" => 'api_key', "extractors" => "entities,topics,words",
            "cleanup.mode" => "raw", "cleanup.returnCleaned" => true, "cleanup.returnRaw" => true, "languageOverride" => 'fre',
            "entities.filterDbpediaTypes" => "type1", "entities.filterFreebaseTypes" => "type2" , "entities.allowOverlap" => false,
            "entities.enrichmentQueries" => "queries", "classifiers" => 'textrazor_iab'})

          Request.post('text', options)
        end

      end

    end

  end

end
