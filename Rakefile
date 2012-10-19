#!/usr/bin/ruby1.9.1

#require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
     t.libs << "."
     t.test_files = FileList['spec/*_spec.rb', 'test/test*.rb']
     t.verbose = true
end

