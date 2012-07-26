module Footing
  module Numeric

    # Returns a positive representation of the number.
    def positive
      return self if self >= 0
      flip_sign
    end

    # Returns a negative representation of the number.
    def negative
      return self if self < 0
      flip_sign
    end

    # Flips the sign on the number making it either either positive or negative.
    def flip_sign
      self * -1
    end

    # Returns the percentage that this number is of the passed number.
    # @example
    #   8.percent_of(10) # => 80.0
    # @param [Numeric] number The number to calculate the percentage with
    def percent_of(number)
      percent = (self.to_f / number.to_f) * 100 if number > 0
      percent ||= 0.0
    end

    # Rounds the number to a certain number of decimal places.
    # @example
    #   1.784329.round_to(1) # => 1.8
    # @param [Numeric] decimal_places The number of decimal places to round to
    def round_to(decimal_places)
      (self * 10**decimal_places).round.to_f / 10**decimal_places
    end

  end
end
