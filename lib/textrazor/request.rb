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

    def self.post(api_key, text, **options)
      ::RestClient.post(
        TextRazor.configuration.url,
        build_query(text, options),
        build_headers(api_key)
      )
    end

    def self.url(path = '/')
      File.join(TextRazor.configuration.url, path)
    end

    private

    def self.build_query(text, options)
      query = { 'text' => text }

      options.each do |key, value|
        value = value.join(",") if value.is_a?(Array)
        query[OPTIONS_MAPPING[key]] = value
      end

      query
    end

    def self.build_headers(api_key)
      { x_textrazor_key: api_key, accept_encoding: 'gzip' }
    end

  end

end
