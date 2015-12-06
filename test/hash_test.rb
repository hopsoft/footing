require File.expand_path("../test_helper", __FILE__)

class HashTest < PryTest::Test
  test ".target_name" do
    assert Footing::Hash.target_name == ::Hash.name
  end

  test ".new with invalid type" do
    begin
      Footing::Hash.new("")
    rescue ArgumentError => error
    end
    assert error
  end

  test ".filter!" do
    dict = {:a => 1, :b => 2, :c => 3}
    Footing::Hash.new(dict).filter!([:b, :c])
    assert dict == {:a => 1, :b => "[FILTERED]", :c => "[FILTERED]"}
  end

  test ".filter! with regexp" do
    dict = {:aaa => 1, :aab => 2, :abb => 3}
    Footing::Hash.new(dict).filter!([:aaa, /ab/], :x)
    assert dict == {:aaa => :x, :aab => :x, :abb => :x}
  end

  test ".filter! nested" do
    dict = { foo: { bar: false }, bar: true}
    Footing::Hash.new(dict).filter!([:bar])
    assert dict == { foo: { bar: "[FILTERED]" }, bar: "[FILTERED]"}
  end

  test ".filter! copy" do
    dict = { foo: { bar: false }, bar: true}
    copy = Footing::Object.new(dict).copy
    Footing::Hash.new(copy).filter!([:bar])
    assert dict == { foo: { bar: false }, bar: true}
    assert copy == { foo: { bar: "[FILTERED]" }, bar: "[FILTERED]"}
  end

end
