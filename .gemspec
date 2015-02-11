# coding: utf-8
Gem::Specification.new do |s|
  s.author = 'Ryan Brewster'
  s.date = '2014-12-22'
  s.email = 'brewster1134@gmail.com'
  s.files = ["Gemfile", "Gemfile.lock", "Guardfile", "README.md", "lib/cli_miami.rb", "lib/namespaced.rb", "lib/cli_miami/ask.rb", "lib/cli_miami/say.rb", "yuyi_menu", ".gitignore", ".rspec", ".travis.yml"]
  s.homepage = 'https://github.com/brewster1134/cli_miami'
  s.license = 'MIT'
  s.name = 'cli_miami'
  s.summary = 'A feature rich alternative for `gets` and `puts` for your cli interface'
  s.version = '0.0.8'
  s.required_ruby_version = '>= 1.9'
  s.add_runtime_dependency 'term-ansicolor', '~> 1.3'
  s.add_development_dependency 'guard', '~> 2.6'
  s.add_development_dependency 'guard-rspec', '~> 4.3'
  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'terminal-notifier-guard', '~> 1.5'
end
