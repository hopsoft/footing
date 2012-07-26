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
    assert { Footing::String.respond_to? :random }
    assert { Footing::String.respond_to? :escape }
    assert { Footing::String.respond_to? :humanize }
    assert { Footing::String.respond_to? :titleize }
    assert { Footing::String.respond_to? :titlecase }
  end

  it "can generate a random_key" do
    Footing.util! Footing::String
    key = Footing::String.random(100)
    assert { key.length == 100 }     # expected length
    assert { (key =~ /\W/).nil? }    # no non-word chars
  end

  it "can generate a random_key with rejected chars" do
    Footing.util! Footing::String
    key = Footing::String.random(100, :upcase => true, :reject => [0, 1, 'I', 'O'])
    assert { key.length == 100 }      # expected length
    assert { (key =~ /\W/).nil? }     # no non-word chars
    assert { (key =~ /[a-z]/).nil? }  # no lowercase chars
    assert { (key =~ /[01IO]/).nil? } # skipped rejected chars
  end

  it "can escape properly" do
    s = "foobar"
    Footing.patch! s, Footing::String
    assert { s.escape("b") == "foo\\bar" }
  end

  it "can titleize" do
    s = "foobar test"
    Footing.patch! s, Footing::String
    assert { s.titleize == "Foobar test" }
  end

  it "can humanize" do
    s = "foo_bar"
    Footing.patch! s, Footing::String
    assert { s.humanize == "Foo bar" }
  end

end
