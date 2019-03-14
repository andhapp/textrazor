module TextRazor

  class Client

    EmptyApiKey = Class.new(StandardError)
    EmptyText = Class.new(StandardError)
    TextTooLong = Class.new(StandardError)
    UnsupportedExtractor = Class.new(StandardError)
    UnsupportedCleanupMode = Class.new(StandardError)

    InvalidDictionary = Class.new(StandardError)
    InvalidDictionaryEntry = Class.new(StandardError)

    DEFAULT_EXTRACTORS = ['entities', 'topics', 'words', 'phrases', 'dependency-trees',
                          'relations', 'entailments', 'senses']

    DEFAULT_CLEANUP_MODE = 'raw'

    VALID_CLEANUP_MODE_VALUES = [DEFAULT_CLEANUP_MODE, 'stripTags', 'cleanHTML']

    REQUEST_OPTIONS = [:extractors, :rules, :cleanup_mode, :cleanup_return_cleaned, :cleanup_return_raw,
                       :language, :dictionaries, :filter_dbpedia_types, :filter_freebase_types, :allow_overlap,
                       :enrichment_queries, :classifiers]

    attr_reader :response, :api_key, :request_options

    private_constant :DEFAULT_EXTRACTORS, :VALID_CLEANUP_MODE_VALUES, :DEFAULT_CLEANUP_MODE, :REQUEST_OPTIONS

    def initialize(api_key, options = {})
      assign_api_key(api_key)
      assign_request_options(options)
    end

    def analyse(text)
      assert_text(text)
      Response.new(Request.post(api_key, text, **request_options))
    end

    def create_dictionary(id, **options)
      dictionary = Dictionary.new(id: id, **options)
      assert_dictionary(dictionary)
      Request.create_dictionary(api_key, dictionary)
    end

    def delete_dictionary(dictionary_id)
      Request.delete_dictionary(api_key, dictionary_id)
    end

    def create_dictionary_entries(dictionary_id, dictionary_entry_hashes)
      dictionary_entries = dictionary_entry_hashes.map do |entry_hash|
        DictionaryEntry.new(entry_hash).tap { |e| assert_dictionary_entry(e) }
      end
      Request.create_dictionary_entries(api_key, dictionary_id, dictionary_entries)
    end

    def delete_dictionary_entry(dictionary_id, dictionary_entry_id)
      Request.delete_dictionary_entry(api_key, dictionary_id, dictionary_entry_id)
    end

    def self.topics(api_key, text, options = {})
      new(api_key, options.merge(extractors: ['topics'])).
        analyse(text).
        topics
    end

    def self.categories(api_key, text, options = {})
      new(api_key, options.merge(classifiers: ['textrazor_iab'])).
        analyse(text).
        categories
    end

    def self.coarse_topics(api_key, text, options = {})
      new(api_key, options.merge(extractors: ['topics'])).
        analyse(text).
        coarse_topics
    end

    def self.entities(api_key, text, options = {})
      new(api_key, options.merge(extractors: ['entities'])).
        analyse(text).
        entities
    end

    def self.words(api_key, text, options = {})
      new(api_key, options.merge(extractors: ['words'])).
        analyse(text).
        entities
    end

    def self.phrases(api_key, text, options = {})
      new(api_key, options.merge(extractors: ['phrases', 'words'])).
        analyse(text).
        phrases
    end

    private

    def assign_api_key(api_key)
      if api_key.nil? || api_key.empty?
        raise EmptyApiKey.new("API key is either nil or empty")
      end

      @api_key = api_key
    end

    def assign_request_options(options)
      extractors = options.delete(:extractors)
      assert_extractors(extractors)

      cleanup_mode = options.delete(:cleanup_mode)
      assert_cleanup_mode(cleanup_mode)

      @request_options = {
        extractors: extractors || DEFAULT_EXTRACTORS,
        cleanup_mode: cleanup_mode || DEFAULT_CLEANUP_MODE
      }

      REQUEST_OPTIONS.each do |key|
        @request_options[key] = options[key] unless options[key].nil?
      end
    end

    def assert_extractors(extractors)
      if extractors && !extractors.all? { |extractor| DEFAULT_EXTRACTORS.include?(extractor) }
        raise UnsupportedExtractor.new('Unsupported extractor')
      end
    end

    def assert_cleanup_mode(cleanup_mode)
      if cleanup_mode && !VALID_CLEANUP_MODE_VALUES.include?(cleanup_mode)
        raise UnsupportedCleanupMode.new('Unsupported clean up mode')
      end
    end

    def assert_text(text)
      if text.nil? || text.empty?
        raise EmptyText.new("Text to be analysed is nil or empty")
      end

      if is_text_bigger_than_200_kb?(text)
        raise TextTooLong.new("Text is more than 200kb")
      end
    end

    def is_text_bigger_than_200_kb?(text)
      text.bytesize/1024.0 > 200
    end

    def assert_dictionary(dictionary)
      raise InvalidDictionary, "Dictionary is invalid" unless dictionary.valid?
    end

    def assert_dictionary_entry(entry)
      raise InvalidDictionaryEntry, "Entry is invalid" unless entry.valid?
    end

  end

end
