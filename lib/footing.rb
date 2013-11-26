require "delegate"
require File.join(File.dirname(__FILE__), "footing", "version")

module Footing

  def self.modules
    [
      "Kernel",
      "Object",
      "String",
      "Numeric",
      "Array",
      "Hash"
    ]
  end

  # Applies all Footing patches.
  def self.patch_all!
    modules.each do |name|
      context = Object.const_get(name)
      footing = Footing.const_get(name)
      patch! context, footing
    end
  end

  # Patches a Module or instance with the given extension.
  # @param [Module, Object] obj The Module or instance to patch.
  # @param [Module] extension The Module that contains the patches.
  def self.patch!(obj, extension)
    context = obj if obj.is_a? Module
    if context.nil?
      begin
        context = class << obj
          self
        end
      rescue Exception
      end
    end

    raise "#{obj.class.name} doesn't support patching!" unless context
    context.send :include, extension
  end

  # Creates util methods for all Footing patches.
  def self.util_all!
    modules.each { |mod| util! Footing.const_get(mod) }
  end

  # Creates class methods for all instance methods in the module.
  # This allows users to invoke utility methods rather than monkey patching if they so desire.
  # @param [Module] mod The Module to setup util methods for.
  def self.util!(mod)
    proxy = Class.new(SimpleDelegator)
    Footing.patch! proxy, mod

    mod.instance_methods(false).each do |method_name|
      mod.define_singleton_method(method_name) do |target, *args|
        method = proxy.instance_method(method_name)
        target = proxy.new(target)
        if method.parameters.empty?
          method.bind(target).call
        else
          method.bind(target).call(*args)
        end
      end
    end
  end

end

Dir[File.expand_path(File.join(File.dirname(__FILE__), "**/*.rb"))].each do |file|
  next if file =~ /#{__FILE__.gsub(".", "\.")}$/
  if ENV["FOOTING_DEV"]
    load file
  else
    require file
  end
end
