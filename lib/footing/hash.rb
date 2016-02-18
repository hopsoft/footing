module Footing
  class Hash < Footing::Object

    class << self
      def new(o={})
        return o if o.is_a?(self)
        super
      end
    end

    def initialize(o={})
      super
      initialize_nested
    end

    def to_h
      copied_object.each_with_object({}) do |pair, memo|
        value = pair.last
        if value.is_a?(Footing::Hash)
          memo[pair.first] = value.to_h
        elsif value.is_a?(::Array)
          memo[pair.first] = value.map do |val|
            if val.is_a?(Footing::Hash)
              val.to_h
            else
              val
            end
          end
        else
          memo[pair.first] = value
        end
      end
    end

    alias_method :to_hash, :to_h

    # Recursively updates keys in place by passing them though the given block.
    # IMPORTANT: This mutates the copied_object.
    #
    # @yield [key] Yields the key to the given block
    # @return [Footing::Hash] Returns self
    def update_keys!(&block)
      @copied_object = copied_object.each_with_object({}) do |pair, memo|
        key = pair.first
        new_key = block.call(key)
        value = pair.last
        if value.is_a?(Footing::Hash)
          memo[new_key] = value.update_keys!(&block)
        elsif value.is_a?(::Array)
          memo[new_key] = value.map do |val|
            if val.is_a?(Footing::Hash)
              val.update_keys!(&block)
            else
              val
            end
          end
        else
          memo[new_key] = value
        end
      end

      self
    end

    # Recursively filters the values for the specified keys in place.
    # IMPORTANT: This mutates the copied_object.
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

      copied_object.each do |key, value|
        if value.is_a?(Footing::Hash)
          value.filter!(keys, replacement: replacement)
        elsif value.is_a?(::Array)
          value.each do |val|
            if val.is_a?(Footing::Hash)
              value.filter!(keys, replacement: replacement)
            end
          end
        else
          value = replacement if should_replace.call(key)
          self[key] = value
        end
      end

      self
    end

    private

    def initialize_nested
      copied_object.each do |key, value|
        if value.is_a? ::Hash
          copied_object[key] = Footing::Hash.new(value)
        elsif value.is_a? ::Array
          copied_object[key] = value.each_with_object([]) do |v, memo|
            v = Footing::Hash.new(v) if v.is_a?(::Hash)
            memo << v
          end
        end
      end
    end
  end
end
