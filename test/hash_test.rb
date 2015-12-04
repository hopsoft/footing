require File.expand_path("../test_helper", __FILE__)

class HashTest < PryTest::Test

  test ".filter!" do
    dict = {:a => 1, :b => 2, :c => 3}
    Footing.hash(dict).filter!([:b, :c])
    assert dict == {:a => 1, :b => "[FILTERED]", :c => "[FILTERED]"}
  end

  test ".filter! with regexp" do
    dict = {:aaa => 1, :aab => 2, :abb => 3}
    Footing.hash(dict).filter!([:aaa, /ab/], :x)
    assert dict == {:aaa => :x, :aab => :x, :abb => :x}
  end

  test ".filter! nested" do
    dict = { foo: { bar: false }, bar: true}
    Footing.hash(dict).filter!([:bar])
    assert dict == { foo: { bar: "[FILTERED]" }, bar: "[FILTERED]"}
  end

  test ".filter! copy" do
    dict = { foo: { bar: false }, bar: true}
    copy = Footing.object(dict).copy
    Footing.hash(copy).filter!([:bar])
    assert dict == { foo: { bar: false }, bar: true}
    assert copy == { foo: { bar: "[FILTERED]" }, bar: "[FILTERED]"}
  end

end
