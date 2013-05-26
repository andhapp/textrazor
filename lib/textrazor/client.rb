module TextRazor

  class Client

    EmptyApiKey = Class.new(StandardError)
    EmptyText = Class.new(StandardError)
    TextTooLong = Class.new(StandardError)

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

    private

    def assign_api_key(api_key)
      if api_key.nil? || api_key.empty?
        raise EmptyApiKey.new("API key is either nil or empty")
      end

      @api_key = api_key
    end

    def assign_request_options(options)
      @request_options = {}
      @request_options[:extractors] = options[:extractors] || Defaults::Extractors
      @request_options[:cleanup_html] = options[:cleanup_html] || Defaults::CleanupHtml
      @request_options[:filter_dbpedia_types] = options[:filter_dbpedia_types] || Defaults::FilterDbpediaTypes
      @request_options[:filter_freebase_types] = options[:filter_freebase_types] || Defaults::FilterFreebaseTypes
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

    class Defaults
      Extractors = ["entities", "topics", "words", "dependency-trees", "relations", "entailments"]
      CleanupHtml = false
      FilterDbpediaTypes = []
      FilterFreebaseTypes = []
    end

  end

end
