require File.join(File.dirname(__FILE__), "..", "lib", "footing")

describe Footing::String do

  it "can patch a string instance" do
    s = ""
    Footing.patch! s, Footing::String
    s.should respond_to(:escape)
    s.should respond_to(:humanize)
    s.should respond_to(:titleize)
    s.should respond_to(:titlecase)
  end

  it "can setup util methods" do
    Footing.util! Footing::String
    Footing::String.should respond_to(:random_key)
    Footing::String.should respond_to(:escape)
    Footing::String.should respond_to(:humanize)
    Footing::String.should respond_to(:titleize)
    Footing::String.should respond_to(:titlecase)
  end

end
