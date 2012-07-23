module Hopsoft

  # Patches the object with all applicable Hopsoft extensions and monkey patches.
  # Works for Modules, Classes, and instances of objects.
  # @param [Object] obj The object to patch.
  def self.patch(obj)
    if obj.class == Module || obj.class == Class
      # patching a Module or Class
      violate(obj)
    else
      # patching an instance
      eigen = nil
      begin
        eigen = class << obj
          self
        end
      rescue Exception => ex
      end

      raise "#{obj.class.name} doesn't support instance patching!" unless eigen
      violate(eigen)
    end
  end

  private

  # Violates the object by applying all applicable Hopsoft extensions and monkey patches.
  # @param [Object] obj The object to voilate.
  def self.violate(obj)
    chain = obj.ancestors.reduce({}) do |memo, ancestor|
      memo[ancestor] = ancestor.name.split("::")
      memo
    end
    chain[obj] = obj.name.split("::") if obj.name

    chain.each do |ancestor, names|
      context = obj
      hopsoft_context = Hopsoft

      names.each do |name|
        const = context.const_get(name)
        hopsoft_const = hopsoft_context.const_get(name) if hopsoft_context.const_defined?(name)
        break unless hopsoft_const.name =~ /^Hopsoft/
        break if hopsoft_const.name =~ /^(Hopsoft|Hopsoft::Object)$/
        const.extend hopsoft_const::ClassMethods if defined?(hopsoft_const::ClassMethods)
        const.send :include, hopsoft_const::InstanceMethods if defined?(hopsoft_const::InstanceMethods)
        context = const
        hopsoft_context = hopsoft_const
      end
    end

    true
  end
end

Dir[File.expand_path(File.join(File.dirname(__FILE__), "**/*.rb"))].each do |file|
  next if file =~ /#{__FILE__.gsub(".", "\.")}$/
  if ENV["HOPSOFT_DEV"]
    load file
  else
    require file
  end
end
