require "rubygems"
require "bundler"
Bundler.require :default, :development
require File.expand_path("../../lib/footing", __FILE__)

Footing.util! Footing::String

Footing.patch! ::Object, Footing::Object
Footing.patch! ::NilClass, Footing::NilClass
Footing.patch! ::Numeric, Footing::Numeric
Footing.patch! ::String, Footing::String
Footing.patch! ::Array, Footing::Array
Footing.patch! ::Hash, Footing::Hash
