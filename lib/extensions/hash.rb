module Footing
  module Hash

    # Rekeys the Hash by invoking a method on the existing keys
    # and uses the return value as the new key.
    #
    # NOTE: Creates and return a new Hash.
    #
    # Example:
    #   h = { [1] => "short", [1,2] => "medium", [1,2,3] => "long" }
    #   h.rekey(:length) # => { 1 => "short", 2 => "medium", 3 => "long" }
    #
    # @param [Symbol] name The method name to invoke on the existing keys.
    # @return [Hash] A new Hash that has been re-keyed.
    def rekey(method_name)
      inject({}) do |new_hash, (key, value)|
        new_hash[key.send(method_name)] = value
        new_hash
      end
    end

  end
end
