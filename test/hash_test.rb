require File.expand_path("../test_helper", __FILE__)

class HashTest < PryTest::Test
  using Footing::Hash

  test ".filter!" do
    dict = { a: 1, b: 2, c: 3 }
    dict.filter!([ :b, :c ])
    assert dict == { a: 1, b: "[FILTERED]", c: "[FILTERED]" }
  end

  test ".filter! with regexp" do
    dict = { aaa: 1, aab: 2, abb: 3 }
    dict.filter!([:aaa, /ab/], replacement: :x)
    assert dict == { aaa: :x, aab: :x, abb: :x }
  end

  test ".filter! nested" do
    dict = { foo: { bar: false }, bar: true }
    dict.filter!([:bar])
    assert dict == { foo: { bar: "[FILTERED]" }, bar: "[FILTERED]" }
  end

  test ".update_keys!" do
    dict = { a: 1, b: 2, c: 3 }
    dict.update_keys! { |key| key.to_s }
    assert dict == { "a" => 1, "b" => 2, "c" => 3 }
  end

  test ".update_keys! with nested hash" do
    dict = { a: 1, b: { c: 3 } }
    dict.update_keys! { |key| key.to_s }
    assert dict == { "a" => 1, "b" => { "c" => 3} }
  end

  test ".update_keys! with nested array with hash" do
    dict = { a: 1, b: [ { c: 3 } ] }
    dict.update_keys! { |key| key.to_s }
    assert dict == { "a" => 1, "b" => [ { "c" => 3 } ] }
  end

  test ".cast_string_values! with boolean" do
    dict = { a: "true", b: "false" }
    assert dict.cast_string_values! == { a: true, b: false }
  end

  test ".cast_string_values! with integer" do
    dict = { a: "1", b: "2" }
    assert dict.cast_string_values! == { a: 1, b: 2 }
  end

  test ".cast_string_values! with float" do
    dict = { a: "1.2", b: "3.14" }
    assert dict.cast_string_values! == { a: 1.2, b: 3.14 }
  end
end
