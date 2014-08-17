require "textrazor/version"
require "textrazor/configuration"
require "textrazor/client"
require "textrazor/request"
require "textrazor/response"
require "textrazor/topic"
require "textrazor/entity"
require "textrazor/word"
require "textrazor/phrase"

module TextRazor

  def self.topics(api_key, text, options = {})
    Client.topics(api_key, text, options)
  end

  def self.entities(api_key, text, options = {})
    Client.entities(api_key, text, options)
  end

  def self.words(api_key, text, options = {})
    Client.words(api_key, text, options)
  end

  def self.phrases(api_key, text, options = {})
    Client.phrases(api_key, text, options)
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

end
