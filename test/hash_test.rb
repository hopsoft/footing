require File.join(File.dirname(__FILE__), "test_helper")

class HashTest < MicroTest::Test

  test ".adjust_values!" do
    dict = {:a => 1, :b => 2, :c => 3}
    Footing.patch! dict, Footing::Hash
    dict.adjust_values! { |v| v.to_s }
    assert dict == {:a=>"1", :b=>"2", :c=>"3"}
  end

  test ".cast_values!" do
    dict = {
      :integer => "1",
      :float => "0.1",
      :true => "true",
      :false => "false",
      :ilist => ["1", "2", "3"],
      :flist => ["0.1", "0.2", "0.3"],
      :nested => {
        :number => "1",
        :true => "true",
        :false => "false",
        :ilist => ["1", "2", "3"],
        :flist => ["0.1", "0.2", "0.3"]
      }
    }

    expected = {
      :integer => 1,
      :float => 0.1,
      :true => true,
      :false => false,
      :ilist => [1, 2, 3],
      :flist => [0.1, 0.2, 0.3],
      :nested => {
        :number => 1,
        :true => true,
        :false => false,
        :ilist => [1, 2, 3],
        :flist => [0.1, 0.2, 0.3]
      }
    }

    assert dict.cast_values! == expected
  end

end
