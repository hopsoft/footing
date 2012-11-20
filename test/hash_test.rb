require File.join(File.dirname(__FILE__), "test_helper")

class HashTest < MicroTest::Test

  test ".adjust_values!" do
    dict = {:a => 1, :b => 2, :c => 3}
    Footing.patch! dict, Footing::Hash
    dict.adjust_values! { |v| v.to_s }
    assert dict == {:a=>"1", :b=>"2", :c=>"3"}
  end

end
