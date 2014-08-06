module TextRazor

  class Client

    EmptyApiKey = Class.new(StandardError)
    EmptyText = Class.new(StandardError)
    TextTooLong = Class.new(StandardError)

    DEFAULT_EXTRACTORS = ['entities', 'topics', 'words', 'phrases', 'dependency-trees',
                          'relations', 'entailments', 'senses']

    REQUEST_OPTIONS = [:extractors, :cleanup_html, :language, :filter_dbpedia_types, :filter_freebase_types]

    attr_reader :response, :api_key, :request_options

    def initialize(api_key, options = {})
      assign_api_key(api_key)
      assign_request_options(options)
    end

    def analyse(text)
      assert_text(text)
      options = {api_key: api_key}.merge(request_options)

      Response.new(Request.post(text, options))
    end

    def self.topics(api_key, text, options = {})
      new(api_key, options.merge(extractors: ['topics'])).
        analyse(text).
        topics
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

    private

    def assign_api_key(api_key)
      if api_key.nil? || api_key.empty?
        raise EmptyApiKey.new("API key is either nil or empty")
      end

      @api_key = api_key
    end

    def assign_request_options(options)
      @request_options = { extractors: DEFAULT_EXTRACTORS }
      REQUEST_OPTIONS.each do |key|
        @request_options[key] = options[key] if options[key]
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

  end

end
