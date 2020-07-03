# frozen_string_literal: true

require 'bundler/audit/task'
require 'cucumber'
require 'cucumber/rake/task'
require 'rubocop/rake_task'
require 'rubygems'

# Add Ins
Bundler::Audit::Task.new
RuboCop::RakeTask.new

# Custom Tasks
desc 'Run rubocop and bundler-audit'
task :checks do
  Rake::Task['rubocop'].invoke
  Rake::Task['bundle:audit'].invoke
end

# Set (Cucumber) features as default
Cucumber::Rake::Task.new(:features) do |t|
  t.profile = 'default'
end
task default: :features
