module Footing
  module Array

    # Recursively casts all string values in this Array.
    # See Footing::String#cast
    def cast_values!
      each_with_index do |value, index|
        if value.respond_to?(:cast_values!)
          value.cast_values!
        elsif value.respond_to?(:cast)
          self[index] = value.cast
        end
      end
      self
    end

  end
end
