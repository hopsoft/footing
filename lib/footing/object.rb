module Footing

  class Object
    attr_reader :wrapped_object

    def initialize(o)
      @wrapped_object = o
    end

    def eigen
      @eigen ||= class << self
        self
      end
    end

    def copy
      Marshal.load(Marshal.dump(wrapped_object))
    end

    def method_missing(name, *args)
      if wrapped_object.respond_to?(name)
        eigen.instance_eval do
          define_method(name) { |*a| wrapped_object.send name, *a }
        end
        return wrapped_object.send name, *args
      end

      super
    end

    def respond_to?(name)
      return true if wrapped_object.respond_to?(name)
      super
    end

  end
end
