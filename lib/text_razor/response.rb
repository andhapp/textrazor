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
      @topics ||= begin
         raw_response["topics"].map do |topic_hash|
           Topic.new(topic_hash["id"], topic_hash["label"], topic_hash["wikiLink"], topic_hash["score"])
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
