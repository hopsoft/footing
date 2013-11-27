require File.expand_path("../test_helper", __FILE__)

class ObjectTest < MicroTest::Test

  test ".eigen" do
    obj = Object.new
    eigen = class << obj
      self
    end
    assert eigen == obj.eigen
  end

  test ".has_eigen false" do
    assert 1.has_eigen? == false
  end

  test ".has_eigen true" do
    obj = Object.new
    assert obj.has_eigen?
  end

  test ".try" do
    obj = Object.new
    assert obj.respond_to?(:foo) == false
    assert Object.new.try(:foo).nil?
    assert obj.respond_to?(:to_s)
    assert Object.new.try(:to_s) != nil
  end

  test ".try with block" do
    obj = Object.new
    assert obj.respond_to?(:foo) == false
    result = obj.try(:foo) do |arg|
    end
    assert result.nil?

    tapped = nil
    assert obj.respond_to?(:tap)
    result = obj.try(:tap) do |arg|
      tapped = arg
    end
    assert obj == tapped
  end

end
