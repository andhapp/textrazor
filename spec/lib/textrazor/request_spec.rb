require 'spec_helper'

module TextRazor

  describe Request do

    let(:api_key) do
      "api_key"
    end

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
          options = { extractors: %w(entities topics words dependency-trees relations entailments) }

          expect(::RestClient).to receive(:post).
            with("https://api.textrazor.com", { "text" => 'text',
                                                 "extractors" => "entities,topics,words,dependency-trees,relations,entailments" }, accept_encoding: 'gzip', x_textrazor_key: 'api_key')

          Request.post(api_key, 'text', **options)
        end

      end

      context "custom options" do

        it "should make correct calls" do
          options = { extractors: %w(entities topics words), cleanup_mode: 'raw',
                     cleanup_return_cleaned: true, cleanup_return_raw: true, language: 'fre',
                     filter_dbpedia_types: %w(type1), filter_freebase_types: %w(type2), allow_overlap: false,
                     enrichment_queries: 'queries', classifiers: 'textrazor_iab'}

          expect(::RestClient).to receive(:post).
            with("https://api.textrazor.com", { "text" => 'text', "extractors" => "entities,topics,words",
                                                 "cleanup.mode" => "raw", "cleanup.returnCleaned" => true, "cleanup.returnRaw" => true, "languageOverride" => 'fre',
                                                 "entities.filterDbpediaTypes" => "type1", "entities.filterFreebaseTypes" => "type2" , "entities.allowOverlap" => false,
                                                 "entities.enrichmentQueries" => "queries", "classifiers" => 'textrazor_iab'},
                                                 accept_encoding: 'gzip', x_textrazor_key: 'api_key')

          Request.post(api_key, 'text', options)
        end

      end

    end

    context ".create_dictionary" do

      let(:dictionary) do
        Dictionary.new(id: "id", match_type: "token", case_insensitive: true, language: "eng")
      end

      it "should make correct calls" do
        expect(::RestClient).to receive(:put).
          with("https://api.textrazor.com/entities/id",
               { "matchType" => "token", "caseInsensitive" => true, "language" => "eng" }.to_json,
               accept_encoding: 'gzip', x_textrazor_key: 'api_key')

        Request.create_dictionary(api_key, dictionary)
      end
    end

    context ".delete_dictionary" do

      it "should make correct calls" do
        expect(::RestClient).to receive(:delete).
          with("https://api.textrazor.com/entities/id",
               accept_encoding: 'gzip', x_textrazor_key: 'api_key'
              )

        Request.delete_dictionary(api_key, "id")
      end
    end

    context ".create_dictionary_entries" do

      let(:dictionary_entries) do
        [DictionaryEntry.new(id: "id", text: "text", data: {key: ["value1", "value2"]})]
      end

      it "should make correct calls" do
        expect(::RestClient).to receive(:post).
          with("https://api.textrazor.com/entities/dictionary_id/",
               [{ "id" => "id", "text" => "text", "data" => { "key" => ["value1", "value2"] }}].to_json,
               accept_encoding: 'gzip', x_textrazor_key: 'api_key')

        Request.create_dictionary_entries(api_key, "dictionary_id", dictionary_entries)
      end
    end

    context ".delete_dictionary_entry" do

      it "should make correct calls" do
        expect(::RestClient).to receive(:delete).
          with("https://api.textrazor.com/entities/dictionary_id/dictionary_entry_id",
               accept_encoding: 'gzip', x_textrazor_key: 'api_key'
              )

        Request.delete_dictionary_entry(api_key, "dictionary_id", "dictionary_entry_id")
      end
    end
  end

end
