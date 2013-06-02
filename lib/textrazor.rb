require "textrazor/version"
require "textrazor/client"
require "textrazor/request"
require "textrazor/response"
require "textrazor/topic"
require "textrazor/entity"

module TextRazor

  def self.topics(api_key, text, options = {})
    Client.topics(api_key, text, options)
  end

  def self.entities(api_key, text, options = {})
    Client.entities(api_key, text, options)
  end

end
