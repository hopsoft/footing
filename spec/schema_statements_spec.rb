require File.join(File.dirname(__FILE__), "spec_helper")
include GrumpyOldMan

describe Footing::PGSchemaStatements do

  before :all do
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

    ar_adapter_mock = MicroMock.make.new
    Footing.patch! ar_adapter_mock, Footing::PGSchemaStatements
    ar_adapter_mock.stub(:quote_table_name) { |name| "\"#{name}\"" }
    ar_adapter_mock.stub(:quote_column_name) { |name| "\"#{name}\"" }
    ar_adapter_mock.stub(:execute) { |sql| @sql = sql }
    ar_adapter_mock.stub(:sql) { @sql }
    @mock = ar_adapter_mock
  end

  it "should create a datetime index with default precision of minute" do
    @mock.add_datetime_index :foo, :bar
    assert_equal @mock.sql, "create index index_foo_on_bar_by_minute on \"foo\" (date_trunc('minute', \"bar\"))"
  end

  it "should create datetime index with all precisions" do
    @precisions.each do |precision|
      @mock.add_datetime_index :foo, :bar, :precision => precision
      assert_equal @mock.sql, "create index index_foo_on_bar_by_#{precision} on \"foo\" (date_trunc('#{precision}', \"bar\"))"
    end
  end

  it "should remove a datetime index" do
    @mock.remove_datetime_index :foo, :bar
    assert_equal @mock.sql, "drop index if exists index_foo_on_bar_by_minute"
  end

  it "should remove a datetime index for all precisions" do
    @precisions.each do |precision|
      @mock.remove_datetime_index :foo, :bar, :precision => precision
      assert_equal @mock.sql, "drop index if exists index_foo_on_bar_by_#{precision}"
    end
  end

  it "should add timestamp indexes" do
    @mock.stub(:execute) { |sql| @sql << sql }
    @mock.stub(:sql) { @sql }
    @mock.instance_eval { @sql = [] }
    @mock.add_timestamp_indexes :foo
    assert @mock.sql.include? "create index index_foo_on_created_at_by_day on \"foo\" (date_trunc('day', \"created_at\"))"
    assert @mock.sql.include? "create index index_foo_on_updated_at_by_day on \"foo\" (date_trunc('day', \"updated_at\"))"
  end

  it "should remove timestamp indexes" do
    @mock.stub(:execute) { |sql| @sql << sql }
    @mock.stub(:sql) { @sql }
    @mock.instance_eval { @sql = [] }
    @mock.remove_timestamp_indexes :foo
    assert @mock.sql.include? "drop index if exists index_foo_on_created_at_by_day"
    assert @mock.sql.include? "drop index if exists index_foo_on_updated_at_by_day"
  end

end
