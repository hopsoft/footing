require File.join(File.dirname(__FILE__), "spec_helper")
include GrumpyOldMan

describe Footing::Hash do

  it "should adjust values" do
    dict = {:a => 1, :b => 2, :c => 3}
    Footing.patch! dict, Footing::Hash
    dict.adjust_values! { |v| v.to_s }
    assert_equal dict, {:a=>"1", :b=>"2", :c=>"3"}
  end

end
