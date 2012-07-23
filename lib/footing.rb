module Footing

  # Applies all Footing patches to core Classes.
  def self.patch_core!
    list = [
      "Kernel",
      "Object",
      "String",
      "Numeric"
    ]

    list.each do |name|
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

end

Dir[File.expand_path(File.join(File.dirname(__FILE__), "**/*.rb"))].each do |file|
  next if file =~ /#{__FILE__.gsub(".", "\.")}$/
  if ENV["FOOTING_DEV"]
    load file
  else
    require file
  end
end
