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

    def self.create_dictionary(api_key, dictionary, **options)
      ::RestClient.put(
        url("/entities/#{dictionary.id}"),
        dictionary.to_h.to_json,
        build_headers(api_key)
      )
      dictionary
    end

    def self.get_dictionary_entries(api_key, dictionary_id, limit:, offset:)
      ::RestClient.get(
        url("entities/#{dictionary_id}/_all?limit=#{limit}&offset=#{offset}"),
        build_headers(api_key)
      )
    end

    def self.delete_dictionary(api_key, dictionary_id)
      ::RestClient.delete(
        url("entities/#{dictionary_id}"),
        build_headers(api_key)
      )
      true
    end

    def self.create_dictionary_entries(api_key, dictionary_id, dictionary_entries)
      ::RestClient.post(
        url("entities/#{dictionary_id}/"),
        dictionary_entries.map(&:to_h).to_json,
        build_headers(api_key)
      )
      dictionary_entries
    end

    def self.delete_dictionary_entry(api_key, dictionary_id, dictionary_entry_id)
      ::RestClient.delete(
        url("entities/#{dictionary_id}/#{dictionary_entry_id}"),
        build_headers(api_key)
      )
      true
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
      { x_textrazor_key: api_key }
    end

  end

end
