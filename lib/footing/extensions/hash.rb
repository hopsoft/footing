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
      reduce({}) do |new_hash, (key, value)|
        new_hash[key.public_send(method_name)] = value
        new_hash
      end
    end

    # Recursively forces all String values to the specified encoding.
    # @param [] encoding The encoding to use.
    # @yield [value] Yields the value after the encoding has been applied.
    def force_encoding!(encoding, &block)
      each do |key, value|
        if value.respond_to?(:force_encoding!)
          value.force_encoding!(encoding, &block)
        elsif value.is_a?(Enumerable)
          value.each do |val|
            next unless val.respond_to?(:force_encoding!)
            val.force_encoding!(encoding, &block)
          end
        elsif value.is_a?(String)
          # force encoding then strip all non ascii chars
          if block_given?
            self[key] = yield(value.force_encoding(encoding))
          else
            self[key] = value.force_encoding(encoding)
          end
        end
      end
    end

    # Recursively adjusts the values of the Hash in place.
    #
    # @example
    #   dict = {:a => 1, :b => 2, :c => 3}
    #   dict.adjust_values! { |v| v.to_s }
    #   dict # => {:a => "1", :b => "2", :c => "3"}
    #
    # @yield [value] Yields the current value to the block.
    #                The result of the block is then assigned to the corresponding key.
    def adjust_values!(&block)
      each do |key, value|
        if value.respond_to?(:adjust_values!)
          value.adjust_values!(&block)
        elsif value.is_a?(Enumerable)
          value.each do |val|
            next unless val.respond_to?(:adjust_values!)
            val.adjust_values!(&block)
          end
        else
          self[key] = yield(value)
        end
      end
      self
    end

    # Recursively casts all string values in this Hash.
    # See Footing::String#cast
    def cast_values!
      each do |key, value|
        if value.respond_to?(:cast_values!)
          value.cast_values!
        elsif value.is_a?(Enumerable)
          value.each do |val|
            next unless val.respond_to?(:cast_values!)
            val.cast_values!
          end
        elsif value.respond_to?(:cast)
          self[key] = value.cast
        end
      end
      self
    end

    def filter!(keys, replacement="[FILTERED]")
      should_replace = lambda do |key|
        replace = false
        keys.each do |k|
          break if replace
          replace = k.is_a?(Regexp) ? key.to_s =~ k : key.to_s == k.to_s
        end
        replace
      end

      each do |key, value|
        if value.respond_to?(:filter!)
          value.filter!(*keys)
        elsif value.is_a?(Enumerable)
          value.each do |val|
            next unless val.respond_to?(:filter!)
            val.filter!(*keys)
          end
        else
          value = replacement if should_replace.call(key)
          self[key] = value
        end
      end
      self
    end

    def silence!(keys)
      filter! keys, nil
    end

  end
end
