# coding: utf-8
require 'date'

Gem::Specification.new do |s|
  s.author = 'Ryan Brewster'
  s.date = Date.today.to_s
  s.email = 'brewster1134@gmail.com'
  s.files = Dir['i18n/*.yml', 'lib/**/*.rb', 'README.md']
  s.homepage = 'https://github.com/brewster1134/CLI-Miami'
  s.license = 'WTFPL'
  s.name = 'cli_miami'
  s.summary = 'A feature rich alternative for `gets` and `puts` for your cli interface'
  s.test_files = Dir['spec/**/*']

  # VERSIONS
  #
  s.version = '1.0.6.pre'

  s.required_ruby_version = Gem::Requirement.new '>= 2.0.0p247'

  s.add_runtime_dependency 'activesupport', '4.2.7.1'
  s.add_runtime_dependency 'i18n', '~> 0'
  s.add_runtime_dependency 'term-ansicolor', '~> 0'

  s.add_development_dependency 'coveralls', '~> 0'
  s.add_development_dependency 'guard', '~> 0'
  s.add_development_dependency 'guard-bundler', '~> 0'
  s.add_development_dependency 'guard-rubocop', '~> 0'
  s.add_development_dependency 'guard-rspec', '~> 0'
  s.add_development_dependency 'listen', '3.0.8'
  s.add_development_dependency 'rspec', '~> 0'
  s.add_development_dependency 'ruby_dep', '1.3.1'
  s.add_development_dependency 'terminal-notifier', '~> 0'
  s.add_development_dependency 'terminal-notifier-guard', '~> 0'
  s.add_development_dependency 'yard', '~> 0'
end
