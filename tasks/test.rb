require "rake/testtask"

desc 'run the test suite'
task :test do
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.test_files = FileList['./test/*/*_test.rb']
    t.verbose = true
    Rake::Task[:destroy].invoke
    Rake::Task[:test_setup].invoke
  end
end
