require "forwardable"

module Footing
  class Object
    extend Forwardable
    def_delegators :"self.class", :wrap

    attr_reader :wrapped_object

    class << self
      def target_name
        self.name.gsub(/\AFooting::/, "")
      end

      def match?(o)
        o.class.ancestors.map(&:name).include?(target_name)
      end

      def wrap(o, copy: true)
        return o if o.is_a?(self)
        new o, copy: copy
      end

      def copy(o)
        Marshal.load Marshal.dump(o)
      end
    end

    def initialize(o, copy: true)
      raise ArgumentError.new("Types must match") unless self.class.match?(o)
      o = self.class.copy(o) if copy
      @wrapped_object = o
    end

    def eigen
      @eigen ||= class << self
        self
      end
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
