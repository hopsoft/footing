require File.join(File.dirname(__FILE__), "spec_helper")

describe Footing::String do

  it "can patch a string instance" do
    s = ""
    Footing.patch! s, Footing::String
    assert { s.respond_to? :escape }
    assert { s.respond_to? :humanize }
    assert { s.respond_to? :titleize }
    assert { s.respond_to? :titlecase }
  end

  it "can setup util methods" do
    Footing.util! Footing::String
    assert { Footing::String.respond_to? :random_key }
    assert { Footing::String.respond_to? :escape }
    assert { Footing::String.respond_to? :humanize }
    assert { Footing::String.respond_to? :titleize }
    assert { Footing::String.respond_to? :titlecase }
  end

end
