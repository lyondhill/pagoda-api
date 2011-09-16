require 'bundler'
require "rspec/core/rake_task"

Bundler::GemHelper.install_tasks

desc "Run all specs"
RSpec::Core::RakeTask.new('spec') do |t|
  t.rspec_opts = ['--colour --format documentation']
end
