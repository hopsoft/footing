module Footing
  module String
    module InstanceMethods

      # Escapes a series of chars in the current string.
      # NOTE: A new string is returned.
      def escape(*chars)
        gsub(/(?<!\\)(#{chars.join("|")})/) do |char|
          "\\" + char
        end
      end

    end
  end
end
