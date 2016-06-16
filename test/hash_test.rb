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

  test ".new with nested hashes" do
    h = Footing::Hash.new(foo: { bar: { baz: true } })
    assert h.is_a?(Footing::Hash)
    assert h[:foo].is_a?(Footing::Hash)
    assert h[:foo][:bar].is_a?(Footing::Hash)
  end

  test ".new with nested array with hashes" do
    h = Footing::Hash.new(foo: { bar: [ {baz: true} ] })
    assert h.is_a?(Footing::Hash)
    assert h[:foo].is_a?(Footing::Hash)
    assert h[:foo][:bar].first.is_a?(Footing::Hash)
  end

  test ".filter!" do
    dict = {:a => 1, :b => 2, :c => 3}
    filtered = Footing::Hash.new(dict).filter!([:b, :c])
    assert dict == {:a => 1, :b => 2, :c => 3}
    assert filtered.to_h == {:a => 1, :b => "[FILTERED]", :c => "[FILTERED]"}
  end

  test ".filter! with regexp" do
    dict = {:aaa => 1, :aab => 2, :abb => 3}
    filtered = Footing::Hash.new(dict).filter!([:aaa, /ab/], replacement: :x)
    assert dict == {:aaa => 1, :aab => 2, :abb => 3}
    assert filtered.to_h == {:aaa => :x, :aab => :x, :abb => :x}
  end

  test ".filter! nested" do
    dict = { foo: { bar: false }, bar: true}
    filtered = Footing::Hash.new(dict).filter!([:bar])
    assert dict == { foo: { bar: false }, bar: true}
    assert filtered.to_h == { foo: { bar: "[FILTERED]" }, bar: "[FILTERED]"}
  end

  test ".update_keys!" do
    dict = {:a => 1, :b => 2, :c => 3}
    rekeyed = Footing::Hash.new(dict).update_keys! { |key| key.to_s }
    assert rekeyed.to_h == {"a" => 1, "b" => 2, "c" => 3}
  end

  test ".update_keys! with nested hash" do
    dict = {:a => 1, :b => { :c => 3 } }
    rekeyed = Footing::Hash.new(dict).update_keys! { |key| key.to_s }
    assert rekeyed.to_h == {"a" => 1, "b" => { "c" => 3} }
  end

  test ".update_keys! with nested array with hash" do
    dict = {:a => 1, :b => [ { :c => 3 } ] }
    rekeyed = Footing::Hash.new(dict).update_keys! { |key| key.to_s }
    assert rekeyed.to_h == {"a" => 1, "b" => [ { "c" => 3 } ] }
  end

  test ".to_h" do
    dict = {:a => 1, :b => 2, :c => 3}
    assert Footing::Hash.new(dict).to_h == dict
  end
end
