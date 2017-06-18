# frozen_string_literal: true

require 'rspec/core/rake_task'

task default: ['spec:all']

namespace :spec do
  desc 'Run all specs'
  task all: %i[rubocop_autocorrect unit]

  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = 'spec/unit/**/*_spec.rb'
  end
end

desc 'Run rubocop with --auto-correct'
task :rubocop_autocorrect do
  require 'rubocop'
  cli = RuboCop::CLI.new
  exit_code = cli.run(%w[--auto-correct])
  exit(exit_code) if exit_code.nonzero?
end
