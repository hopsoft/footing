# Extend Rails to support adding timestamp indexes for created_at & updated_at using day granularity.
#
# @example Make these statements available to ActiveRecord::Migration change, up, down methods
#   # rails_root/config/application.rb
#   config.after_initialize do
#     Footing.patch! ActiveRecord::ConnectionAdapters::AbstractAdapter, Footing::PGSchemaStatements
#   end
#
module Footing
  module PGSchemaStatements

    # Adds indexes to the created_at and updated_at timestamp columns with 'day' granularity.
    def add_timestamp_indexes(table_name)
      %w(created_at updated_at).each do |column_name|
        add_datetime_index(table_name, column_name, :precision => :day)
      end
    end

    # Removes indexes to the created_at and updated_at timestamp columns with 'day' granularity.
    def remove_timestamp_indexes(table_name)
      %w(created_at updated_at).each do |column_name|
        remove_datetime_index(table_name, column_name, :precision => :day)
      end
    end

    # Adds an index on a datetime column using the specified precision.
    # @param [Symbol,String] table_name The name of the table to migrate.
    # @param [Symbol,String] column_name The name of the column to migrate.
    # @param [Hash] options
    # @option options [Symbol,String] :precision
    #   - microseconds
    #   - milliseconds
    #   - second
    #   - minute *default
    #   - hour
    #   - day
    #   - week
    #   - month
    #   - quarter
    #   - year
    #   - decade
    #   - century
    #   - millennium
    def add_datetime_index(table_name, column_name, options={})
      options[:precision] ||= :minute
      index_name = "index_#{table_name}_on_#{column_name}_by_#{options[:precision]}"
      execute "create index #{index_name} on #{quote_table_name(table_name)} (date_trunc('#{options[:precision]}', #{quote_column_name(column_name)}))"
    end

    # Removes an index on a datetime column using the specified precision.
    # @param [Symbol,String] table_name The name of the table to migrate.
    # @param [Symbol,String] column_name The name of the column to migrate.
    # @param [Hash] options
    # @option options [Symbol,String] :precision
    #   - microseconds
    #   - milliseconds
    #   - second
    #   - minute *default
    #   - hour
    #   - day
    #   - week
    #   - month
    #   - quarter
    #   - year
    #   - decade
    #   - century
    #   - millennium
    def remove_datetime_index(table_name, column_name, options={})
      options[:precision] ||= :minute
      index_name = "index_#{table_name}_on_#{column_name}_by_#{options[:precision]}"
      execute "drop index if exists #{index_name}"
    end

  end
end
