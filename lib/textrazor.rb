require "textrazor/version"
require "textrazor/client"
require "textrazor/request"
require "textrazor/response"
require "textrazor/topic"

module TextRazor

  def self.topics(api_key, text, options = {})
    Client.topics(api_key, text, options)
  end

end
