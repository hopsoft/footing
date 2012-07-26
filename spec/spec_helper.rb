require File.join(File.dirname(__FILE__), "..", "lib", "footing")

# A simple assert for RSpec so I don't have to learn a complex
# nomenclature that eventually boils down to a basic "assert" anyway.
# @example
#   assert { 1.to_s == "1" }
def assert(&block)
  block.call.should equal true
end
