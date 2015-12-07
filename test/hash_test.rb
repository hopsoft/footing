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

  test ".filter! in place" do
    dict = {:a => 1, :b => 2, :c => 3}
    Footing::Hash.new(dict, copy: false).filter!([:b, :c])
    assert dict == {:a => 1, :b => "[FILTERED]", :c => "[FILTERED]"}
  end

  test ".filter!" do
    dict = {:a => 1, :b => 2, :c => 3}
    filtered = Footing::Hash.new(dict).filter!([:b, :c])
    assert dict == {:a => 1, :b => 2, :c => 3}
    assert filtered.wrapped_object == {:a => 1, :b => "[FILTERED]", :c => "[FILTERED]"}
  end

  test ".filter! with regexp" do
    dict = {:aaa => 1, :aab => 2, :abb => 3}
    filtered = Footing::Hash.new(dict).filter!([:aaa, /ab/], replacement: :x)
    assert dict == {:aaa => 1, :aab => 2, :abb => 3}
    assert filtered.wrapped_object == {:aaa => :x, :aab => :x, :abb => :x}
  end

  test ".filter! nested" do
    dict = { foo: { bar: false }, bar: true}
    filtered = Footing::Hash.new(dict).filter!([:bar])
    assert dict == { foo: { bar: false }, bar: true}
    assert filtered.wrapped_object == { foo: { bar: "[FILTERED]" }, bar: "[FILTERED]"}
  end

end
