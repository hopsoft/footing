require File.join(File.dirname(__FILE__), "spec_helper")
include GrumpyOldMan

describe Footing::NilClass do

  it "support []" do
    Footing.patch! NilClass, Footing::NilClass
    assert_equal nil[:foo], nil
  end

  it "should support deeply nested [] on Hash" do
    Footing.patch! NilClass, Footing::NilClass
    dict = {}
    assert_equal dict[:foo][:bar][:other], nil
  end

end
