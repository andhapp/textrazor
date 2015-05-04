require 'bundler/gem_tasks'
require 'bundler/setup'
require 'rspec/core/rake_task'

desc 'Run all the specs'
RSpec::Core::RakeTask.new(:spec) do |task|
  task.pattern = "spec/lib/**/*_spec.rb"
end

desc 'Run all the functional specs'
RSpec::Core::RakeTask.new(:specf) do |task|
  task.pattern = "spec/functional/*_spec.rb"
end

task :default => [:spec, :specf]
