require 'rake'
require 'rake/testtask'

Rake::TestTask.new(:'test:unit') do |t|
  t.libs << "test"
  t.pattern = "test/unit/**/*_test.rb"
  t.verbose = true
end

Rake::TestTask.new(:'test:integration') do |t|
  t.libs << "test"
  t.pattern = "test/integration/**/*_test.rb"
  t.verbose = true
end

task test: [:'test:unit', :'test:integration']

task default: [:test]

