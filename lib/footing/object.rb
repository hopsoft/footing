module Footing
  class Object
    attr_reader :original_object, :copied_object

    class << self
      def target_name
        self.name.gsub(/\AFooting::/, "")
      end

      def match?(o)
        o.class.ancestors.map(&:name).include?(target_name)
      end

      def new(o)
        return o if o.is_a?(self)
        super
      end
    end

    def initialize(o)
      raise ArgumentError.new("Types must match") unless self.class.match?(o)
      @original_object = o
      @copied_object = o.dup
    end

    def method_missing(name, *args)
      if copied_object.respond_to?(name)
        return copied_object.send name, *args
      end

      super
    end

    def respond_to?(name)
      return true if copied_object.respond_to?(name)
      super
    end

  end
end
