# coding: utf-8
Gem::Specification.new do |s|
  s.author = 'Ryan Brewster'
  s.date = '2016-02-26'
  s.email = 'brewster1134@gmail.com'
  s.files = Dir['i18n/*.yml', 'lib/**/*.rb', 'README.md']
  s.homepage = 'https://github.com/brewster1134/CLI-Miami'
  s.license = 'WTFPL'
  s.name = 'cli_miami'
  s.summary = 'A feature rich alternative for `gets` and `puts` for your cli interface'
  s.test_files = Dir['spec/**/*']

  # VERSIONS
  #
  s.version = '1.0.3.pre'

  s.required_ruby_version = Gem::Requirement.new '>= 2.0.0p247'

  s.add_runtime_dependency 'activesupport', '~> 4.2'
  s.add_runtime_dependency 'i18n', '~> 0.7'
  s.add_runtime_dependency 'term-ansicolor', '~> 1.3'

  s.add_development_dependency 'coveralls', '~> 0.7'
  s.add_development_dependency 'guard', '~> 2.6'
  s.add_development_dependency 'guard-bundler', '~> 2.1'
  s.add_development_dependency 'guard-rubocop', '~> 1.2'
  s.add_development_dependency 'guard-rspec', '~> 4.3'
  s.add_development_dependency 'listen', '~> 3.0.7', '>= 3.0.7'
  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'terminal-notifier-guard', '~> 1.5'
end
