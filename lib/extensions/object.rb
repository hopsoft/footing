module Footing
  module Object

    def self.included(mod)
      mod.send :include, InstanceMethods
    end

    module InstanceMethods

      # Returns the eigen class for the object.
      def eigen
        eigen = class << self
          self
        end
      rescue Exception => ex
        nil
      end

      # Indicates if the object has an eigen class.
      def has_eigen?
        !eigen.nil?
      end

    end
  end
end
