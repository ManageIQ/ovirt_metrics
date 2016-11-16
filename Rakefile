require "bundler/gem_tasks"

begin
  require "rspec/core/rake_task"

  RSpec::Core::RakeTask.new(:spec) do
    puts "Testing with Rails #{ENV["RAILS_VERSION"]}..." if ENV["RAILS_VERSION"]
  end
rescue LoadError
end

task :test => :spec
task :default => :spec
