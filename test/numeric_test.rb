require File.expand_path("../test_helper", __FILE__)

class NumericTest < MicroTest::Test

  test ".positive" do
    assert -10.positive == 10
  end

  test ".negative" do
    assert 10.negative == -10
  end

  test ".flip_sign" do
    assert 10.flip_sign == -10
    assert -10.flip_sign == 10
  end

  test ".percent_of" do
    assert 10.percent_of(100) == 10
    assert 50.percent_of(100) == 50
    assert 70.percent_of(100) == 70
    assert 10.percent_of(1000) == 1
    assert 100.percent_of(1000) == 10
    assert 1000.percent_of(1000) == 100
  end

  test ".round_to" do
    assert 1.0009.round_to(2) == 1
    assert 1.066.round_to(2) == 1.07
    assert 1.867.round_to(2) == 1.87
    assert 1.789259.round_to(5) == 1.78926
  end

end
