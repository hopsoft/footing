require File.expand_path("../test_helper", __FILE__)

class NilTest < MicroTest::Test

  test "[]" do
    assert nil[:foo] == nil
  end

  test "deeply nested [] on Hash" do
    dict = {}
    assert dict[:foo][:bar][:baz] == nil
  end

end
