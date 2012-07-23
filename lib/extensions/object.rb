module Footing
  module Object
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
