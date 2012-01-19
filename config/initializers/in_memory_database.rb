def in_memory_sqlite?
  Rails.env == "test" and
    ActiveRecord::Base.connection.class == ActiveRecord::ConnectionAdapters::SQLiteAdapter ||
      ActiveRecord::Base.connection.class == ActiveRecord::ConnectionAdapters::SQLite3Adapter and
    Rails.configuration.database_configuration['test']['database'] = ':memory:'
end

if in_memory_sqlite?
  puts "Creating SQLite in-memory database."
  load "#{Rails.root}/db/schema.rb"
end
