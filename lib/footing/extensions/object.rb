module Footing
  module Object

    # Returns the eigen class for the object.
    def eigen
      class << self
        self
      end
    rescue Exception
      nil
    end

    # Indicates if the object has an eigen class.
    def has_eigen?
      !eigen.nil?
    end

    # Trys to invoke a method on the object.
    # Returns nil if the method isn't supported.
    def try(name, *args, &block)
      if respond_to?(name)
        return public_send(name, *args, &block)
      end
      nil
    end

  end
end
