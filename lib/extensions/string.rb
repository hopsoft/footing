module Footing
  module String

    def self.included(mod)
      mod.extend ClassMethods
      mod.send :include, InstanceMethods
    end

    module ClassMethods

      ## Generates a random string (upcase alpha-numeric)
      ## Returns a string with the length provided, defaulting to 12 chars
      def random_key(length=12)
        chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"
        chars.split('').sample(length).join
      end

    end

    module InstanceMethods

      # Escapes a series of chars in the current string.
      # NOTE: A new string is returned.
      def escape(*chars)
        gsub(/(?<!\\)(#{chars.join("|")})/) do |char|
          "\\" + char
        end
      end

      # Converts a word with underscores into a sentance with a capitalized first word.
      def humanize
        self.downcase.gsub(/_/, " ").capitalize
      end

      # Similar to humanize but it capitalizes each word
      def titleize
        self.split('_').map(&:capitalize).join(' ')
      end

    end

  end
end
