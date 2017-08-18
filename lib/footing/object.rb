module Footing
  module Object
    refine ::Object do
      # Creates a deep copy of this object.
      def replicate
        ::Marshal.load ::Marshal.dump(self)
      end
    end
  end
end
