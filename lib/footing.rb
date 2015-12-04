$:.unshift File.dirname(__FILE__)
require "footing/version"
require "footing/object"
require "footing/hash"
require "pry"

module Footing
  eigen = class << self
    self
  end

  classes = constants.each_with_object([]) do |name, memo|
    constant = const_get(name)
    memo << constant if constant.is_a?(Class)
  end

  classes.each do |klass|
    name = klass.name
    chars = name.gsub(/\AFooting|::/, "").each_char.to_a

    method_name = chars.map do |char|
      char =~ /(?<!^)[A-Z]/ ? "_#{char.downcase}" : char.downcase
    end.join

    eigen.class_eval do
      define_method "#{method_name}?" do |o|
        o.is_a? klass
      end
    end

    eigen.class_eval do
      define_method method_name do |o|
        return o if send("#{method_name}?", o)
        klass.new o
      end
    end
  end
end
