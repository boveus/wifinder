require "rake"
require "rake/testtask"
require 'pry'

Dir[File.dirname(__FILE__) + "/tasks/*.rb"].sort.each do |path|
  require path
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['./test/*/*_test.rb']
  t.verbose = true
  Rake::Task[:destroy].invoke
  Rake::Task[:test_setup].invoke
end

task default: [:test]
