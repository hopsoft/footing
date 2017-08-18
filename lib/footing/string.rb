module Footing
  module String
    refine ::String do
      # Indicates if this string represents a number.
      def numeric?
        !!(self =~ /\A[0-9]+\.*[0-9]*\z/)
      end

      # Indicates if this string represents a boolean value.
      def boolean?
        !!(self =~ /\A(true|false)\z/i)
      end

      # Escapes a series of chars.
      def escape(*chars)
        self.gsub(/(?<!\\)(#{chars.join("|")})/) do |char|
          "\\#{char}"
        end
      end

      # Casts this string to another datatype.
      # Supported datatypes:
      # * Integer
      # * Float
      # * Boolean
      def cast
        return to_f if numeric? && index(".")
        return to_i if numeric?
        if boolean?
          return true if self =~ /\Atrue\z/i
          return false if self =~ /\Afalse\z/i
        end
        self
      end
    end
  end
end
