require 'rest_client'

module TextRazor

  class Request

    def self.post(text, options)
      ::RestClient.post "http://api.textrazor.com/", build_query(text, options), accept_encoding: 'gzip'
    end

    private

    def self.build_query(text, options)
      query = {"text" => text, "apiKey" => options.delete(:api_key)}

      options.each do |key, value|
        value = value.join(",") if value.is_a?(Array)

        key = "cleanupHTML" if key == :cleanup_html
        key = "entities.filterDbpediaTypes" if key == :filter_dbpedia_types
        key = "entities.filterFreebaseTypes" if key == :filter_freebase_types

        query.merge!(key.to_s => value)
      end

      query
    end

  end

end
