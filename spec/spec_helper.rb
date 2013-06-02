require "bundler"
Bundler.require

require 'ostruct'
require 'rspec/fire'
require File.expand_path("../../lib/textrazor" ,__FILE__)

RSpec.configure do |config|
  config.include(RSpec::Fire)
end
