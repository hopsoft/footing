require File.expand_path("../test_helper", __FILE__)

class ObjectTest < PryTest::Test

  test "copy" do
    obj = Object.new
    footing_obj = Footing.object(obj)
    copy = footing_obj.copy

    assert obj == footing_obj.wrapped_object
    assert !obj.eql?(copy)
  end

end
