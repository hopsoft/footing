module Footing
  module NilClass

    # Calling [] on nil returns nil instead of raising an exception.
    # Helpful when looping over nested Hashes.
    #
    # @example
    #   dict = {}
    #   dict[:foo][:bar][:baz] # => nil
    #
    # @param [Object] key The key to lookup.
    def [](key)
      nil
    end

  end
end
