require File.expand_path("../test_helper", __FILE__)

class StringTest < PryTest::Test
  using Footing::String

  test ".numeric? integer" do
    assert "4323".numeric?
  end

  test ".numeric? float" do
    assert "43.835875".numeric?
  end

  test ".numeric? invalid" do
    refute "43.835.875".numeric?
  end

  test ".boolean? true" do
    assert "true".boolean?
    assert "TRUE".boolean?
  end

  test ".boolean? false" do
    assert "false".boolean?
    assert "FALSE".boolean?
  end

  test ".escape" do
    assert "'foobar'".escape("'", "b") == "\\'foo\\bar\\'"
  end

  test ".cast integer" do
    assert "42".cast == 42
  end

  test ".cast float" do
    assert "3.14".cast == 3.14
  end

  test ".cast true" do
    assert "true".cast == true
    assert "True".cast == true
    assert "TRUE".cast == true
  end

  test ".cast false" do
    assert "false".cast == false
    assert "False".cast == false
    assert "FALSE".cast == false
  end

  test ".cast string" do
    assert "foobar".cast == "foobar"
  end
end
