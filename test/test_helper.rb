require "rubygems"
require "bundler"
Bundler.require :default, :development
require File.join(File.dirname(__FILE__), "..", "lib", "footing")

Footing.patch_all!
