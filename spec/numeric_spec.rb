require File.join(File.dirname(__FILE__), "spec_helper")
include GrumpyOldMan

describe Footing::Hash do
  Footing.patch! Numeric, Footing::Numeric

  it "should support positive" do
    assert_equal -10.positive, 10
  end

  it "should support negative" do
    assert_equal 10.negative, -10
  end

  it "should flip_sign" do
    assert_equal 10.flip_sign, -10
    assert_equal -10.flip_sign, 10
  end

  it "should support percent_of" do
    assert_equal 10.percent_of(100), 10
    assert_equal 50.percent_of(100), 50
    assert_equal 70.percent_of(100), 70
    assert_equal 10.percent_of(1000), 1
    assert_equal 100.percent_of(1000), 10
    assert_equal 1000.percent_of(1000), 100
  end

end

