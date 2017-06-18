# frozen_string_literal: true

guard :rspec, cmd: 'bundle exec rspec' do
  require 'guard/rspec/dsl'
  dsl = Guard::RSpec::Dsl.new(self)

  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)
  watch(%r{^lib/.+/(.+)\.rb$}) do |m|
    (0..23).map { |hour| "spec/unit/word_clock/#{m[1]}_#{hour}_spec.rb" }
  end

  watch(%r{^lib(/.+/.+)\.rb$}) do |m|
    "spec/unit#{m[1]}_spec.rb"
  end

  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)
end

guard 'bundler' do
  watch('Gemfile')
  watch(/^.*\.gemspec/)
end
