require 'json'

module TextRazor

  class Response

    BadRequest = Class.new(StandardError)
    Unauthorised = Class.new(StandardError)
    RequestEntityTooLong = Class.new(StandardError)

    attr_reader :raw_response

    def initialize(http_response)
      code = http_response.code
      body = http_response.body

      raise BadRequest.new(body) if bad_request?(code)
      raise Unauthorised.new(body) if unauthorised?(code)
      raise RequestEntityTooLong.new(body) if request_entity_too_long?(code)

      @raw_response = ::JSON.parse(body)["response"]
    end

    def topics
      raw_topics = raw_response["topics"]
      return nil if raw_topics.nil?

      @topics ||= begin
         raw_topics.map do |topic_hash|
           Topic.create_from_hash(topic_hash)
         end
      end
    end

    def entities
      raw_entities = raw_response["entities"]
      return nil if raw_entities.nil?

      @entities ||= begin
         raw_entities.map do |entity_hash|
           Entity.create_from_hash(entity_hash)
         end
      end
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

  end

end
