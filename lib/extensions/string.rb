module Footing
  module String

    # Generates a random string.
    #
    # @example
    #   Footing.util! Footing::String
    #   Footing::String.random_key(100, :reject => ["1", "I", "l", "0", "O"])
    #
    # @param [Integer] length The length of the key to generate. Defaults to 12.
    # @param [Hash] opts
    # @option opts [Array] :reject A list of characters to omit from the key.
    # @option opts [Boolean] :upcase Indicates that only use uppercase characters should be used.
    # @return [String]
    def random(length=12, opts={})
      @chars ||= [(0..9).to_a, ('a'..'z').to_a, ('A'..'Z').to_a].flatten.map { |c| c.to_s }
      chars = @chars.reject do |c|
        c =~ /[a-z]/ if opts[:upcase]
      end
      opts[:reject] ||= []
      opts[:reject] = opts[:reject].map { |c| c.to_s }
      (1..length).map{ |i| (chars - opts[:reject]).sample }.join
    end
    alias :random_key :random

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
    alias :titlecase :titleize

  end
end
