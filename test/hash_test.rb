require File.expand_path("../test_helper", __FILE__)

class HashTest < MicroTest::Test

  test ".adjust_values!" do
    dict = {:a => 1, :b => 2, :c => 3}
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

  test ".filter!" do
    dict = {:a => 1, :b => 2, :c => 3}
    dict.filter!([:b, :c])
    assert dict == {:a => 1, :b => "[FILTERED]", :c => "[FILTERED]"}
  end

  test ".silence!" do
    dict = {:a => 1, :b => 2, :c => 3}
    dict.silence!([:a, :b])
    assert dict == {:a => nil, :b => nil, :c => 3}
  end

end
