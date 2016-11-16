# coding: utf-8
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'date'
require 'cli_miami/metadata'

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |s|
  s.author      = 'Ryan Brewster'
  s.date        = Date.today.to_s
  s.email       = 'brewster1134@gmail.com'
  s.files       = Dir['{bin,i18n,lib}/**/*', 'CHANGELOG.md', 'README.md']
  s.homepage    = 'https://github.com/brewster1134/cli_miami'
  s.license     = 'WTFPL'
  s.name        = 'cli_miami'
  s.summary     = CliMiami::SUMMARY
  s.test_files  = Dir['spec/**/*']
  s.version     = CliMiami::VERSION

  s.required_ruby_version = Gem::Requirement.new '>= 2.1.0'

  s.add_runtime_dependency 'activesupport', '>0'
  s.add_runtime_dependency 'i18n', '>0'
  s.add_runtime_dependency 'rb-readline', '>0'
  s.add_runtime_dependency 'recursive-open-struct', '>0'
  s.add_runtime_dependency 'thor', '>0'

  s.add_development_dependency 'coveralls', '>0'
  s.add_development_dependency 'guard', '>0'
  s.add_development_dependency 'guard-bundler', '>0'
  s.add_development_dependency 'guard-rubocop', '>0'
  s.add_development_dependency 'guard-rspec', '>0'
  s.add_development_dependency 'rspec', '>0'
  s.add_development_dependency 'terminal-notifier', '>0'
  s.add_development_dependency 'terminal-notifier-guard', '>0'
end
# rubocop:enable Metrics/BlockLength
