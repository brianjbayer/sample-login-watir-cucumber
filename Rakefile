# frozen_string_literal: true

require 'bundler/audit/task'
require 'cucumber'
require 'cucumber/rake/task'
require 'parallel_tests/tasks'
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

# Cucumber Tasks
Cucumber::Rake::Task.new(:cucumber) do |t|
  t.profile = 'default'
end

namespace :cucumber do
  desc 'Run Cucumber features in parallel using parallel_tests'
  task :parallel do
    if ENV['BROWSER'] == 'safari'
      warn 'rake: running specs SEQUENTIALLY for safari'
      Rake::Task[:cucumber].invoke
    else
      Rake::Task['parallel:features'].invoke
    end
  end
end

# Set the Default to running in parallel
task default: 'cucumber:parallel'
