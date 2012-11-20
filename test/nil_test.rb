require File.join(File.dirname(__FILE__), "test_helper")

class NilTest < MicroTest::Test

  test "[]" do
    Footing.patch! NilClass, Footing::NilClass
    assert nil[:foo] == nil
  end

  test "deeply nested [] on Hash" do
    Footing.patch! NilClass, Footing::NilClass
    dict = {}
    assert dict[:foo][:bar][:baz] == nil
  end

end
