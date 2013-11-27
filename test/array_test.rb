require File.expand_path("../test_helper", __FILE__)

class ArrayTest < MicroTest::Test

  test ".cast_values!" do
    list = [
      "1",
      "2",
      "3",
      "0.1",
      "0.2",
      "0.3",
      "true",
      "false",
      [
        "1",
        "2",
        "3",
        "0.1",
        "0.2",
        "0.3",
        "true",
        "false"
      ],
      {
        :number => "1",
        :true => "true",
        :false => "false",
        :ilist => ["1", "2", "3"],
        :flist => ["0.1", "0.2", "0.3"]
      }
    ]
    expected = [
      1,
      2,
      3,
      0.1,
      0.2,
      0.3,
      true,
      false,
      [
        1,
        2,
        3,
        0.1,
        0.2,
        0.3,
        true,
        false
      ],
      {
        :number => 1,
        :true => true,
        :false => false,
        :ilist => [1, 2, 3],
        :flist => [0.1, 0.2, 0.3],
      }
    ]
    assert list.cast_values! == expected
  end

end
