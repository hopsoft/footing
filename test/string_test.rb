require File.join(File.dirname(__FILE__), "test_helper")

class StringTest < MicroTest::Test
  Footing.util! Footing::String

  test "patch a string instance" do
    s = ""
    Footing.patch! s, Footing::String
    assert s.respond_to? :escape
    assert s.respond_to? :humanize
    assert s.respond_to? :titleize
    assert s.respond_to? :titlecase
  end

  test ".util!" do
    assert Footing::String.respond_to? :random
    assert Footing::String.respond_to? :escape
    assert Footing::String.respond_to? :humanize
    assert Footing::String.respond_to? :titleize
    assert Footing::String.respond_to? :titlecase
  end

  test ".random" do
    key = Footing::String.random(100)
    assert key.length == 100 # expected length
    assert (key =~ /\W/).nil?    # no non-word chars
  end

  test ".random with rejected chars" do
    key = Footing::String.random(100, :upcase => true, :reject => [0, 1, 'I', 'O'])
    assert key.length == 100  # expected length
    assert (key =~ /\W/).nil?     # no non-word chars
    assert (key =~ /[a-z]/).nil?  # no lowercase chars
    assert (key =~ /[01IO]/).nil? # skipped rejected chars
  end

  test ".escape" do
    s = "foobar"
    Footing.patch! s, Footing::String
    assert s.escape("b") == "foo\\bar"
  end

  test ".titleize" do
    s = "foobar test"
    Footing.patch! s, Footing::String
    assert s.titleize == "Foobar test"
  end

  test ".humanize" do
    s = "foo_bar"
    Footing.patch! s, Footing::String
    assert s.humanize == "Foo bar"
  end

  test ".numeric? integers" do
    (0..100).each do |i|
      s = i.to_s
      Footing.patch! s, Footing::String
      assert s.numeric?
    end
  end

  test ".numeric? floats" do
    (0..100).each do |i|
      s = i.to_f.to_s
      Footing.patch! s, Footing::String
      assert s.numeric?
    end
    s = "7843.7897389"
    Footing.patch! s, Footing::String
    assert s.numeric?
    s = "7843.789.7389"
    Footing.patch! s, Footing::String
    assert !s.numeric?
  end

  test ".boolean?" do
    s = "true"
    Footing.patch! s, Footing::String
    assert s.boolean?

    s = "false"
    Footing.patch! s, Footing::String
    assert s.boolean?

    s = " true"
    Footing.patch! s, Footing::String
    assert !s.boolean?

    s = "false "
    Footing.patch! s, Footing::String
    assert !s.boolean?
  end

end
