require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :test => :spec
task :default => :spec

namespace :spec do
  desc "Setup test databases (ovirt_engine_history and rhevm_history)"
  task :setup do
    require 'active_record'
    require 'pg'

    databases = {
      'ovirt_engine_history' => File.expand_path('spec/schemas/schema_rhev40.rb', __dir__),
      'rhevm_history'        => File.expand_path('spec/schemas/schema_rhev31.rb', __dir__)
    }

    databases.each do |db_name, schema_file|
      puts "\n=== Setting up #{db_name} ==="

      # Connect to postgres database to create the target database
      begin
        conn = PG.connect(:dbname => 'postgres', :host => ENV['PGHOST'] || 'localhost', :user => ENV['PGUSER'] || 'root', :password => ENV['PGPASSWORD'] || 'smartvm')

        # Check if database exists
        result = conn.exec_params('SELECT 1 FROM pg_database WHERE datname = $1', [db_name])

        if result.ntuples > 0
          puts "Database '#{db_name}' already exists, dropping..."
          # Terminate existing connections
          conn.exec(<<~SQL)
            SELECT pg_terminate_backend(pg_stat_activity.pid)
            FROM pg_stat_activity
            WHERE pg_stat_activity.datname = '#{db_name}'
              AND pid <> pg_backend_pid();
          SQL
          conn.exec("DROP DATABASE #{db_name}")
        end

        puts "Creating database '#{db_name}'..."
        conn.exec("CREATE DATABASE #{db_name}")
        conn.close
        puts "Database '#{db_name}' created successfully."
      rescue PG::Error => e
        puts "Error with database operations: #{e.message}"
        exit 1
      end
      # Load schema
      puts "Loading schema from '#{schema_file}'..."
      begin
        ActiveRecord::Base.establish_connection(
          :adapter  => 'postgresql',
          :database => db_name,
          :host     => ENV['PGHOST'] || 'localhost',
          :username => ENV['PGUSER'] || 'root',
          :password => ENV['POSTGRES_PASSWORD'] || 'smartvm'
        )

        ActiveRecord::Schema.verbose = false
        load schema_file

        puts "Schema loaded successfully for '#{db_name}'."
      rescue => e
        puts "Error loading schema: #{e.message}"
        puts e.backtrace.join("\n")
        exit 1
      ensure
        ActiveRecord::Base.connection.close if ActiveRecord::Base.connected?
      end
    end

    puts "\n=== Setup complete! ==="
    puts "Databases created:"
    databases.each do |db_name, schema_file|
      puts "  - #{db_name} (schema: #{File.basename(schema_file)})"
    end
  end
end
