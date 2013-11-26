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

  end
end
