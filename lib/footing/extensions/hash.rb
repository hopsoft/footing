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

    # Adjusts the values of the Hash in place.
    #
    # @example
    #   dict = {:a => 1, :b => 2, :c => 3}
    #   dict.adjust_values! { |v| v.to_s }
    #   dict # => {:a => "1", :b => "2", :c => "3"}
    #
    # @yield [value] Yields the current value to the block.
    #                The result of the block is then assigned to the corresponding key.
    def adjust_values!
      each { |k, v| self[k] = yield(v) }
    end

    # Recursively casts all string values in this Hash.
    # See Footing::String#cast
    def cast_values!
      each do |key, value|
        if value.respond_to?(:cast_values!)
          value.cast_values!
        elsif value.respond_to?(:cast)
          self[key] = value.cast
        end
      end
      self
    end

  end
end
