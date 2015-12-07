module Footing
  class Object
    extend Forwardable

    attr_reader :inner_object

    class << self
      def target_name
        self.name.gsub(/\AFooting::/, "")
      end

      def match?(o)
        o.class.ancestors.map(&:name).include?(target_name)
      end

      def new(o, copy: true)
        return o if o.is_a?(self)
        super o, copy: copy
      end

      def copy(o)
        Marshal.load Marshal.dump(o)
      end
    end

    def initialize(o, copy: true)
      raise ArgumentError.new("Types must match") unless self.class.match?(o)
      o = self.class.copy(o) if copy
      @inner_object = o
    end

    def eigen
      @eigen ||= class << self
        self
      end
    end

    def method_missing(name, *args)
      if inner_object.respond_to?(name)
        eigen.instance_eval do
          define_method(name) { |*a| inner_object.send name, *a }
        end
        return inner_object.send name, *args
      end

      super
    end

    def respond_to?(name)
      return true if inner_object.respond_to?(name)
      super
    end

  end
end
