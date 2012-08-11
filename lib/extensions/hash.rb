module Footing
  module Hash

    # Rekeys the Hash by invoking a method on the existing keys
    # and uses the return value as the new key.
    #
    # NOTE: Creates and returns a new Hash.
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

    # Recursively forces all String values to the specified encoding.
    # @param [] encoding The encoding to use.
    # @yield [value] Yields the value after the encoding has been applied.
    def force_encoding!(encoding, &block)
      each do |key, value|
        case value
          when String
            # force encoding then strip all non ascii chars
            if block_given?
              self[key] = yield(value.force_encoding(encoding))
            else
              self[key] = value.force_encoding(encoding)
            end
          when Hash then value.force_encoding!(encoding, &block)
        end
      end
    end

  end
end
