require "rubygems"
require "bundler"
Bundler.require :default, :development
require "coveralls"
Coveralls.wear!
SimpleCov.command_name 'pry-test'

require File.expand_path("../../lib/footing", __FILE__)
