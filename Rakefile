require 'rake/testtask'
require 'rubygems'

# rake test
# To run a specific file:  rake test TEST=test/test_ftdi.rb
# To run a specific method:
#   rake test TEST=test/test_ftdi.rb TESTOPTS="--name=test_ftdi_method"
Rake::TestTask.new do |t|
  t.libs << "lib"
  t.verbose = true
end

# rake gem
require 'rake/gempackagetask'
spec = Gem::Specification.new do |s|
  s.name                  = 'ftdi'
  s.summary               = 'Ruby bindings for libftdi'
  s.description           = File.read(File.join(File.dirname(__FILE__), 'README'))
  s.version               = '0.0.1'
  s.requirements          = ['libftdi']
  s.author                = 'Jason Heiss'
  s.email                 = 'jheiss@aput.net'
  s.homepage              = 'http://github.com/jheiss/ftdi'
  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = '>=1.8'
  s.files                 = FileList['README', 'LICENSE', 'examples/**', 'ext/**', 'test/**']
  s.test_files            = FileList['test/test*.rb']
  s.extensions            = ["ext/extconf.rb"]
end
Rake::GemPackageTask.new(spec).define

