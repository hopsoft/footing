require "delegate"
require File.expand_path("../footing/version", __FILE__)

module Footing
  class << self

    # Patches a Module or instance with the given extension.
    # @param [Module, Object] obj The Module or instance to patch.
    # @param [Module] extension The Module that contains the patches.
    def patch!(obj, extension)
      context = patch_context(obj)
      raise "#{obj.class.name} doesn't support patching!" unless context
      context.send :include, extension
    end

    # Creates class methods for all instance methods in the module.
    # This allows users to invoke utility methods rather than monkey patching if they so desire.
    # @param [Module] mod The Module to setup util methods for.
    def util!(mod)
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

    private

    def patch_context(obj)
      context = obj if obj.is_a? Module
      begin
        context ||= class << obj
          self
        end
      rescue Exception
      end
      context
    end

  end
end

Dir[File.expand_path("../**/*.rb", __FILE__)].each do |file|
  next if file =~ /(lib\/footing\.rb|version\.rb)\z/
  ENV["FOOTING_DEV"] ? load(file) : require(file)
end
