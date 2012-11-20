require File.join(File.dirname(__FILE__), "footing", "version")

module Footing

  def self.modules
    [
      "Kernel",
      "Object",
      "String",
      "Numeric",
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
      rescue Exception => ex
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
    proxy = ::Object.new
    proxy_eigen = class << proxy
      self
    end

    Footing.patch! proxy, mod

    eigen = class << mod
      self
    end

    mod.instance_methods(false).each do |method|
      eigen.send :define_method, method do |*args|
        o = args.first || proxy
        m = proxy_eigen.instance_method(method)
        if m.parameters.empty?
          m.bind(o).call
        else
          m.bind(o).call(*args)
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
