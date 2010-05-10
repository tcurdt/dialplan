require 'rubygems'
require 'rake/testtask'

task :default => [:generate]

Rake::TestTask.new do |t|
  t.libs << 'src/main/ruby'
  t.test_files = FileList["src/test/ruby/**/*_test.rb"]
  t.verbose = true
end

task :generate do

    require 'json'
    require 'plist'
    require 'yaml'
    
    dialplan = YAML.load_file('dialplan.yaml')

    File.open('dialplan.json', 'w') { |f| f.write(dialplan.to_json) }
    File.open('dialplan.plist', 'w') { |f| f.write(dialplan.to_plist) }
    `/usr/bin/plutil -convert binary1 dialplan.plist`
    
end
