require File.join(File.dirname(__FILE__), "test_helper")

class StringTest < MicroTest::Test
  Footing.util! Footing::String
  Footing.patch! String, Footing::String

  test "patch a string instance" do
    s = ""
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
    assert Footing::String.respond_to? :boolean?
    assert Footing::String.respond_to? :numeric?
    assert Footing::String.respond_to? :cast
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
    assert "foobar".escape("b") == "foo\\bar"
  end

  test ".titleize" do
    assert "foobar test".titleize == "Foobar test"
  end

  test ".humanize" do
    assert "foo_bar".humanize == "Foo bar"
  end

  test ".numeric? integers" do
    (0..100).each do |i|
      s = i.to_s
      assert s.numeric?
    end
  end

  test ".numeric? floats" do
    (0..100).each do |i|
      s = i.to_f.to_s
      assert s.numeric?
    end
    assert "7843.7897389".numeric?
    assert !"7843.789.7389".numeric?
  end

  test ".boolean?" do
    assert "true".boolean?
    assert "false".boolean?
    assert !" true".boolean?
    assert !"false ".boolean?
  end

  test ".cast" do
    assert "1.23".cast == 1.23
    assert "87843".cast == 87843
    assert "true".cast == true
    assert "false".cast == false
  end


end
