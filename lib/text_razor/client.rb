module TextRazor

  class Client

    attr_reader :text, :api_key, :extractors, :cleanup_html,
                :filter_dbpedia_types, :filter_freebase_types

    def initialize(api_key, text, options = {})
      assign_api_key(api_key)
      assign_text(text)
      assign_options(options)
    end

    private

    def assign_api_key(api_key)
      if api_key.nil? || api_key.empty?
        raise EmptyApiKey.new("API key is either nil or empty")
      end

      @api_key = api_key
    end

    def assign_text(text)
      if text.nil? || text.empty?
        raise EmptyText.new("Text to be analysed is nil or empty")
      end

      if is_text_bigger_than_200_kb?(text)
        raise TextTooLong.new("Text is more than 200kb")
      end

      @text = text
    end

    def assign_options(options)
      @extractors = options[:extractors] || Defaults::Extractors
      @cleanup_html = options[:cleanup_html] || Defaults::CleanupHtml
      @filter_dbpedia_types = options[:filter_dbpedia_types] || Defaults::FilterDbpediaTypes
      @filter_freebase_types = options[:filter_freebase_types] || Defaults::FilterFreebaseTypes
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
