require 'spec_helper'

module TextRazor

  describe Request do

    context ".post" do

      context "default options" do

        it "should make correct calls" do
          options = {api_key: 'api_key', extractors: %w(entities topics words dependency-trees relations entailments),
                     cleanup_html: false, filter_dbpedia_types: [], filter_freebase_types: []}

          ::RestClient.should_receive(:post).
            with("http://api.textrazor.com/", { "text" => 'text', "apiKey" => 'api_key', "cleanupHTML" => false,
            "extractors" => "entities,topics,words,dependency-trees,relations,entailments", "entities.filterDbpediaTypes" => "",
            "entities.filterFreebaseTypes" => ""}, accept_encoding: 'gzip')

          Request.post('text', options)
        end

      end

      context "custom options" do

        it "should make correct calls" do
          options = {api_key: 'api_key', extractors: %w(entities topics words), cleanup_html: true,
                     filter_dbpedia_types: %w(type1), filter_freebase_types: %w(type2)}

          ::RestClient.should_receive(:post).
            with("http://api.textrazor.com/", { "text" => 'text', "apiKey" => 'api_key', "extractors" => "entities,topics,words",
            "cleanupHTML" => true, "entities.filterDbpediaTypes" => "type1", "entities.filterFreebaseTypes" => "type2" },
             accept_encoding: 'gzip')

          Request.post('text', options)
        end

      end

    end

  end

end
