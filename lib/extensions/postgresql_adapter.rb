# Extend Rails with this module to add a uuid method in your migrations.
#
# Example:
#   # rails_root/config/application.rb
#   config.after_initialize do
#     Footing.patch! ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::TableDefinition, Footing::PGTableDefinition
#   end
#
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
