module Footing

  # Patches the object with all applicable Hopsoft extensions and monkey patches.
  # Works for Modules, Classes, and instances of objects.
  # @param [Object] obj The object to patch.
  def self.patch!(obj)
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

  # Violates the object by applying all applicable Footing extensions and monkey patches.
  # @param [Object] obj The object to voilate.
  def self.violate(obj)
    chain = obj.ancestors.reduce({}) do |memo, ancestor|
      memo[ancestor] = ancestor.name.split("::")
      memo
    end
    chain[obj] = obj.name.split("::") if obj.name

    chain.each do |ancestor, names|
      context = obj
      footing_context = Footing

      names.each do |name|
        const = context.const_get(name)
        footing_const = footing_context.const_get(name) if footing_context.const_defined?(name) break unless footing_const.name =~ /^Footing/
        break if footing_const.name =~ /^(Footing|Footing::Object)$/
        const.extend footing_const::ClassMethods if defined?(footing_const::ClassMethods)
        const.send :include, footing_const::InstanceMethods if defined?(footing_const::InstanceMethods)
        context = const
        footing_context = footing_const
      end
    end

    true
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
