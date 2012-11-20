module Footing
  module NilClass

    # Similar to ActiveSupport's #try added to NilClass.
    # Calling [] on nil always returns nil.
    # It becomes especially helpful when navigating through deeply nested Hashes.
    #
    # @example
    #   dict = {}
    #   dict[:foo][:bar][:other] # => nil
    #
    # @param [Object] key The key to lookup.
    def [](key)
      nil
    end

  end
end
