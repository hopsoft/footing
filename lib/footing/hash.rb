module Footing
  class Hash < Footing::Object

    def filter!(keys, replacement="[FILTERED]")
      should_replace = lambda do |key|
        replace = false
        keys.each do |k|
          break if replace
          replace = k.is_a?(Regexp) ? key.to_s =~ k : key.to_s == k.to_s
        end
        replace
      end

      wrapped_object.each do |key, value|
        if value.is_a?(::Hash)
          wrap(value).filter!(keys, replacement)
        elsif value.is_a?(Enumerable)
          value.each do |val|
            if val.is_a?(::Hash)
              wrap(val).filter!(keys, replacement)
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
