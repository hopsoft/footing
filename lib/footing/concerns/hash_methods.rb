module Footing
  module HashMethods

    # Recursively filters the values for the specified keys in place.
    # IMPORTANT: This mutates the Hash.
    #
    # @param keys [Array<Symbol,String,Regexp>] The keys to filter
    # @param replacement [Object] The replacement value to use
    # @return [Footing::Hash] Returns self
    def filter!(keys, replacement: "[FILTERED]")
      should_replace = lambda do |key|
        replace = false
        keys.each do |k|
          break if replace
          replace = k.is_a?(Regexp) ? key.to_s =~ k : key.to_s == k.to_s
        end
        replace
      end

      inner_object.each do |key, value|
        if value.is_a?(::Hash)
          Footing::Hash.new(value, copy: false).filter!(keys, replacement: replacement)
        elsif value.is_a?(Enumerable)
          value.each do |val|
            if val.is_a?(::Hash)
              Footing::Hash.new(val, copy: false).filter!(keys, replacement: replacement)
            end
          end
        else
          value = replacement if should_replace.call(key)
          self[key] = value
        end
      end

      self
    end

  end
end
