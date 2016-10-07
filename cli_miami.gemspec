# coding: utf-8
$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'date'
require 'cli_miami/version'

Gem::Specification.new do |s|
  s.author      = 'Ryan Brewster'
  s.date        = Date.today.to_s
  s.email       = 'brewster1134@gmail.com'
  s.files       = Dir['{bin,i18n,lib}/**/*', 'README.md']
  s.homepage    = 'https://github.com/brewster1134/CLI-Miami'
  s.license     = 'WTFPL'
  s.name        = 'cli_miami'
  s.summary     = 'A feature rich alternative for `gets` and `puts` for your cli interface'
  s.test_files  = Dir['spec/**/*']
  s.version     = CliMiami::VERSION

  s.required_ruby_version = Gem::Requirement.new '>= 2.0.0p247'

  s.add_runtime_dependency 'activesupport', '4.2.7.1'
  s.add_runtime_dependency 'i18n'
  s.add_runtime_dependency 'term-ansicolor'

  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'guard-rubocop'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'listen', '3.0.8'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'ruby_dep', '1.3.1'
  s.add_development_dependency 'terminal-notifier'
  s.add_development_dependency 'terminal-notifier-guard'
  s.add_development_dependency 'yard'
end
