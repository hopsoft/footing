require File.expand_path("../test_helper", __FILE__)

class ObjectTest < PryTest::Test

  test ".wrap once" do
    obj = Object.new
    wrapped = Footing::Object.wrap(obj)
    assert obj == wrapped.wrapped_object
    assert wrapped.class.ancestors.include?(Footing::Object)
  end

  test ".wrap multiple" do
    obj = Object.new
    wrapped1 = Footing::Object.wrap(obj)
    wrapped2 = Footing::Object.wrap(wrapped1)
    assert wrapped1.eql?(wrapped2)
  end

  test ".eigen" do
    obj = Object.new
    wrapped = Footing::Object.wrap(obj)
    eigen = class << wrapped; self; end
    assert eigen.eql?(wrapped.eigen)
  end

  test ".copy" do
    obj = Object.new
    wrapped = Footing::Object.new(obj)
    copy = wrapped.copy
    assert obj == wrapped.wrapped_object
    assert !obj.eql?(copy)
  end

end
