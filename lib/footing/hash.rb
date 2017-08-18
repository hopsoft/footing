module Footing
  module Hash
    refine ::Hash do
      using Footing::String

      # Recursively updates string values in place by casting them to the appropriate type.
      # See Footing::String#cast
      def cast_string_values!
        each { |key, value| self[key] = cast_value(value) }
        self
      end

      # Recursively updates keys in place by passing them though the given block.
      def update_keys!(&block)
        keys.each { |key| update_key key, &block }
        self
      end

      # Recursively updates values in place by passing them though the given block.
      def update_values!(&block)
        keys.each { |key, value| update_value_for key, &block }
        self
      end

      # Recursively filters the values for the specified keys in place.
      def filter!(keys_to_filter, replacement: "[FILTERED]")
        each do |key, value|
          self[key] = filtered_value(key, keys_to_filter, replacement: replacement)
        end
        self
      end

      private

        def should_filter_value?(key, keys_to_filter)
          should_filter = false
          keys_to_filter.each do |k|
            break if should_filter
            should_filter = k.is_a?(::Regexp) ? key.to_s =~ k : key.to_s == k.to_s
          end
          !!should_filter
        end

        def filtered_value(key, keys_to_filter, replacement: "[FILTERED]")
          value = self[key]
          return value.filter!(keys_to_filter, replacement: replacement) if value.is_a?(::Hash)
          return value.map { |v| filter_value(key, keys_to_filter, replacement: replacement) } if value.is_a?(::Enumerable)
          return replacement if should_filter_value?(key, keys_to_filter)
          value
        end

        def cast_value(value)
          return value.cast                      if value.is_a?(::String)
          return value.cast_string_values!       if value.is_a?(::Hash)
          return value.map { |v| cast_value(v) } if value.is_a?(::Enumerable)
          value
        end

        def update_key(key, &block)
          value = self[key]
          new_key = block.call(key)
          case value
          when ::Hash then value = value.update_keys!(&block)
          when ::Enumerable then value = value.map { |v| v.is_a?(::Hash) ? v.update_keys!(&block) : v }
          end
          self.delete key
          self[new_key] = value
        end

        def update_value_for(key, &block)
          value = self[key]
          case value
          when ::Hash then new_value = value.update_values!(&block)
          when ::Enumerable then new_value = value.map { |v| v.is_a?(::Hash) ? v.update_values!(&block) : v }
          else new_value = block.call(value)
          end
          self[key] = new_value
        end
    end
  end
end
