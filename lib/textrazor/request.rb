require 'rest_client'

module TextRazor

  class Request

    def self.post(text, options)
      ::RestClient.post "http://api.textrazor.com/", build_query(text, options), accept_encoding: 'gzip'
    end

    private

    def self.build_query(text, options)
      {"text" => text, "apiKey" => options[:api_key], "extractors" => options[:extractors].join(","),
       "cleanupHTML" => options[:cleanup_html], "entities.filterDbpediaTypes" => options[:filter_dbpedia_types].join(","),
       "entities.filterFreebaseTypes" => options[:filter_freebase_types].join(",")}
    end

  end

end
