require File.expand_path("../test_helper", __FILE__)

class SchemaStatementsTest < MicroTest::Test

  before do
    @precisions = %w(
      microseconds
      milliseconds
      second
      minute *default
      hour
      day
      week
      month
      quarter
      year
      decade
      century
      millennium
    )

    @mock = MicroMock.make.new
    @mock.def(:quote_table_name) { |name| "\"#{name}\"" }
    @mock.def(:quote_column_name) { |name| "\"#{name}\"" }
    @mock.def(:execute) { |sql| @sql = sql }
    @mock.def(:sql) { @sql }
    Footing.patch! @mock, Footing::PGSchemaStatements
  end

  test "create a datetime index with default precision of minute" do
    @mock.add_datetime_index :foo, :bar
    assert @mock.sql == "create index index_foo_on_bar_by_minute on \"foo\" (date_trunc('minute', \"bar\"))"
  end

  test "create datetime index with all precisions" do
    @precisions.each do |precision|
      @mock.add_datetime_index :foo, :bar, :precision => precision
      assert @mock.sql == "create index index_foo_on_bar_by_#{precision} on \"foo\" (date_trunc('#{precision}', \"bar\"))"
    end
  end

  test "remove a datetime index" do
    @mock.remove_datetime_index :foo, :bar
    assert @mock.sql == "drop index if exists index_foo_on_bar_by_minute"
  end

  test "remove a datetime index for all precisions" do
    @precisions.each do |precision|
      @mock.remove_datetime_index :foo, :bar, :precision => precision
      assert @mock.sql == "drop index if exists index_foo_on_bar_by_#{precision}"
    end
  end

  test "add timestamp indexes" do
    @mock.def(:execute) { |sql| @sql << sql }
    @mock.def(:sql) { @sql }
    @mock.instance_eval { @sql = [] }
    @mock.add_timestamp_indexes :foo
    assert @mock.sql.include? "create index index_foo_on_created_at_by_day on \"foo\" (date_trunc('day', \"created_at\"))"
    assert @mock.sql.include? "create index index_foo_on_updated_at_by_day on \"foo\" (date_trunc('day', \"updated_at\"))"
  end

  test "remove timestamp indexes" do
    @mock.def(:execute) { |sql| @sql << sql }
    @mock.def(:sql) { @sql }
    @mock.instance_eval { @sql = [] }
    @mock.remove_timestamp_indexes :foo
    assert @mock.sql.include? "drop index if exists index_foo_on_created_at_by_day"
    assert @mock.sql.include? "drop index if exists index_foo_on_updated_at_by_day"
  end

end
