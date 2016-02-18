require File.expand_path("../test_helper", __FILE__)

class ObjectTest < PryTest::Test

  test ".new once" do
    obj = Object.new
    copy = Footing::Object.new(obj)
    assert copy.class.ancestors.include?(Footing::Object)
  end

  test ".new multiple" do
    obj = Object.new
    copy1 = Footing::Object.new(obj)
    copy2 = Footing::Object.new(copy1)
    assert copy1.eql?(copy2)
  end

end
