# Extend Rails to support adding timestamp indexes for created_at & updated_at using day granularity.
# Footing.patch! ActiveRecord::ConnectionAdapters::AbstractAdapter, Footing::PGSchemaStatements
module Footing
  module PGSchemaStatements

    # Adds indexes to the created_at and updated_at timestamp columns with 'day' granularity.
    # This method is available to ActiveRecord::Migration change, up, down methods.
    def add_timestamp_indexes(table_name)
      %w(created_at updated_at).each do |column_name|
        name = "index_#{table_name}_on_#{column_name}"
        execute "create index #{name} on #{quote_table_name(table_name)} (date_trunc('day', #{quote_column_name(column_name)}))"
      end
    end

    # Removes indexes to the created_at and updated_at timestamp columns with 'day' granularity.
    # This method is available to ActiveRecord::Migration change, up, down methods.
    def remove_timestamp_indexes(table_name)
      %w(created_at updated_at).each do |column_name|
        name = "index_#{table_name}_on_#{column_name}"
        execute "drop index if exists #{name}"
      end
    end

  end
end
