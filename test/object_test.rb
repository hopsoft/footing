require File.expand_path("../test_helper", __FILE__)

class ObjectTest < PryTest::Test
  using Footing::Object

  test ".copy simple" do
    obj = Object.new
    assert !obj.equal?(obj.replicate)
  end

  test ".copy nil" do
    obj = nil
    assert obj.equal?(obj.replicate)
    assert obj == obj.replicate
  end

  test ".copy number" do
    obj = 3.14
    assert obj.equal?(obj.replicate)
    assert obj == obj.replicate
  end

  test ".copy string" do
    obj = "foo"
    assert !obj.equal?(obj.replicate)
    assert obj == obj.replicate
  end

  test ".copy array" do
    obj = (1..10).to_a
    assert !obj.equal?(obj.replicate)
    assert obj == obj.replicate
  end

  test ".copy hash" do
    obj = { a: true, b: [ { c: 3.14 } ] }
    assert !obj.equal?(obj.replicate)
    assert obj == obj.replicate
  end
end
