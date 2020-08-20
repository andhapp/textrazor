require 'rest_client'

module TextRazor

  class Request

    OPTIONS_MAPPING = {
      extractors: 'extractors',
      cleanup_mode: 'cleanup.mode',
      cleanup_return_cleaned: 'cleanup.returnCleaned',
      cleanup_return_raw: 'cleanup.returnRaw',
      language: 'languageOverride',
      dictionaries: 'entities.dictionaries',
      filter_dbpedia_types: 'entities.filterDbpediaTypes',
      filter_freebase_types: 'entities.filterFreebaseTypes',
      allow_overlap: 'entities.allowOverlap',
      enrichment_queries: 'entities.enrichmentQueries',
      classifiers: 'classifiers'
    }

    def self.post(text, options)
      ::RestClient.post(
        TextRazor.configuration.url,
        build_query(text, options)
      )
    end

    private

    def self.build_query(text, options)
      query = {"text" => text, "apiKey" => options.delete(:api_key)}

      options.each do |key, value|
        value = value.join(",") if value.is_a?(Array)
        query[OPTIONS_MAPPING[key]] = value
      end

      query
    end

  end

end
