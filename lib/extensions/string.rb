module Footing
  module String

    def self.included(mod)
      mod.extend ClassMethods
      mod.send :include, InstanceMethods
    end

    module ClassMethods

      ## Generates a random string (upcase alpha-numeric)
      ## Returns a string with the length provided, defaulting to 12 chars
      def random(length=12)
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        (0...length).map { chars.split('')[rand(chars.length)] }.join
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
        ret = []
        self.split('_').each_with_index do |w, idx|
          if idx == 0
            ret << w.capitalize
          else
            ret << w
          end
        end
        ret.join(' ')
      end

      # Similar to humanize but it capitalizes each word
      def titleize
        self.split('_').map(&:capitalize).join(' ')
      end

    end

  end
end
