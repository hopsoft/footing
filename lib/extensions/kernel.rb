module Footing
  module Kernel

    # Safely evals text inside of a sandbox.
    # @see http://phrogz.net/programmingruby/taint.html Ruby safe level description.
    # @param [String] text The text to eval.
    # @param [Integer] level The safe level to apply.
    # @return [Object]
    def safe_eval(text, level=4)
      sandbox = lambda do
        $SAFE = level
        eval(text.to_s)
      end
      sandbox.call
    end

  end
end
