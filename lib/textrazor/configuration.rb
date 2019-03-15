module TextRazor

  class Configuration
    DEFAULT_ENDPOINT = "api.textrazor.com"
    EUROPE_ENDPOINT = "api-eu.textrazor.com"

    attr_accessor :secure, :use_europe_endpoint

    def initialize
      @secure = true
      @use_europe_endpoint = false
    end

    def url
      URI::Generic.build(
        host: (use_europe_endpoint ? EUROPE_ENDPOINT : DEFAULT_ENDPOINT),
        scheme: (secure ? "https" : "http")
      ).to_s
    end

  end

end
