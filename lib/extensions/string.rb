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

    # Compare two strings and return floating point precision metric. Will work
    #   with any string, including urls.
    # @param [String] string1 First string. The baseline string that will
    #   compared against.
    # @param [String] string2 Second string. The comparison string that will be
    #   matched against the baseline.
    # @return [Float]
    # @note: Final score will not be effected by switching the baseline and the
    #   comparison strings.
    # @example
        #entropy "this", ""
        # => 0.0
        #entropy "this", "  "
        # => 0.0
        #entropy "this", "t"
        # => 0.0
        #entropy "this", "th"
        # => 0.5
        #entropy "this", "thi"
        # => 0.8
        #entropy "this", "this"
        # => 1.0
    def self.entropy(string1, string2)
      string1.downcase!
      string2.downcase!
      #Build a range for the string length-2,collect every 2nd group of chars,reject anything " "
      pairs1 = (0..string1.length-2).collect {|i| string1[i,2]}.reject {|pair1| pair1.include? " "}
      pairs2 = (0..string2.length-2).collect {|n| string2[n,2]}.reject {|pair2| pair2.include? " "}
      #Sum all elements
      union = pairs1.size + pairs2.size
      #Set a value to zero
      intersection = 0
      #Iterate over first subset of elements
      pairs1.each do |p_one|
        #Count iteration over the rest of the subset of elements (optional: pairs2.size-1 or pairs2.size. TODO: see where this matters)
        0.upto(pairs2.size-1) do |i|
          if p_one == pairs2[i]
            #Increment number of similar grouped characters
            intersection += 1
            pairs2.slice!(i)
            #Break in case we get into some strange loop. This is not necessary but its a nice safeguard.
            break
          end
        end
      end
      (2.0 * intersection) / union
    end

  end
end
