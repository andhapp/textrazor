require 'json'

module TextRazor

  class Response

    BadRequest = Class.new(StandardError)
    Unauthorised = Class.new(StandardError)
    RequestEntityTooLong = Class.new(StandardError)

    attr_reader :raw_response, :time

    def initialize(http_response)
      code = http_response.code
      body = http_response.body

      raise BadRequest.new(body) if bad_request?(code)
      raise Unauthorised.new(body) if unauthorised?(code)
      raise RequestEntityTooLong.new(body) if request_entity_too_long?(code)

      json_body = ::JSON::parse(body, symbolize_names: true)

      @time = json_body[:time].to_f
      @ok = json_body[:ok]
      @raw_response = json_body[:response]
    end

    def ok?
      @ok
    end

    #TODO: Not in a successful response
    #def error
    #end

    #def message
    #end

    def custom_annotation_output
      @custom_annotation_output ||= raw_response[:customAnnotationOutput]
    end

    def cleaned_text
      @cleaned_text ||= raw_response[:cleanedText]
    end

    def raw_text
      @raw_text||= raw_response[:rawText]
    end

    def entailments
      @entailments ||= parse_entailments
    end

    def entities
      @entities ||= parse_entities
    end

    def coarse_topics
      @coarse_topics ||= parse_coarse_topics
    end

    def topics
      @topics ||= parse_topics
    end

    def phrases
      @phrases ||= parse_phrases
    end

    def words
      @words ||= parse_words
    end

    def properties
      @properties ||= parse_properties
    end

    def relations
      @relations ||= parse_relations
    end

    def sentences
       @sentences ||= parse_sentences
    end

    def language
      raw_response[:language]
    end

    def language_is_reliable?
      raw_response[:languageIsReliable]
    end

    private

    def bad_request?(code)
      code == 400
    end

    def unauthorised?(code)
      code == 401
    end

    def request_entity_too_long?(code)
      code == 413
    end

    def parse_entailments
      parse(:entailment, raw_response[:entailments])
    end

    def parse_entities
      parse(:entity, raw_response[:entities])
    end

    def parse_coarse_topics
      parse(:topic, raw_response[:coarseTopics])
    end

    def parse_topics
      parse(:topic, raw_response[:topics])
    end

    def parse_phrases
      raw_phrases = raw_response[:nounPhrases]
      return if raw_phrases.nil?

      raw_phrases.map do |phrase_hash|
        Phrase.create_from_hash(phrase_hash, words)
      end
    end

    def parse_words
      raw_sentences = raw_response[:sentences]
      return if raw_sentences.nil?

      words = []
      raw_sentences.each do |sentence_hash|
        sentence_hash[:words].each do |word_hash|
          words << Word.create_from_hash(word_hash)
        end
      end
      words
    end

    def parse_properties
      parse(:property, raw_response[:properties])
    end

    def parse_relations
      parse(:relation, raw_response[:relations])
    end

    def parse_sentences
      parse(:sentence, raw_response[:sentences])
    end

    def parse(type, data)
      return nil if data.nil?

      klass = Object.const_get("TextRazor::#{type.capitalize}")

      data.map do |data_hash|
        klass.create_from_hash(data_hash)
      end
    end
  end

end
