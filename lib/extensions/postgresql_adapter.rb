# Extend Rails with this module to add a uuid method in your migrations.
# Footing.patch! ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::TableDefinition, Footing::PGTableDefinition
module Footing
  module PGTableDefinition

    # Provides a uuid method when inside a migration's create_table block.
    def uuid(*args)
      options = args.extract_options!
      #column(args[0], 'uuid default uuid_generate_v1()', options)
      column(args[0], 'uuid', options)
    end

  end
end
