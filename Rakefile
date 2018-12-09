# frozen_string_literal: true

begin
  require "bundler/audit/task"
  require "bundler/gem_tasks"
  require "gemsmith/rake/setup"
  require "git/cop/rake/setup"
  require "reek/rake/task"
  require "rspec/core/rake_task"
  require "rubocop/rake_task"

  RSpec::Core::RakeTask.new(:spec)
rescue LoadError => error
  puts error.message
end

desc "Run code quality checks"
task code_quality: %i[bundle:audit git_cop reek rubocop]

task default:      %i[code_quality spec]
