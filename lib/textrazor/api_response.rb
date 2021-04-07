require 'json'

module TextRazor

  class ApiResponse

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
