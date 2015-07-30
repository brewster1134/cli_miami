notification :terminal_notifier, subtitle: 'CLI Miami'

guard :bundler do
  watch 'Gemfile'
end

guard :rubocop, cli: '-D' do
  watch(/(.+\.rb)$/)                  { |m| m[0] }
  watch(%r{(?:.+/)?\.rubocop\.yml$})  { |m| File.dirname(m[0]) }
end

guard :rspec, cmd: 'bundle exec rspec --color --format d' do
  watch(%r{^spec/lib/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})       { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^lib/namespaced.rb$})  { 'spec/lib/cli_miami_spec.rb' }
  watch('spec/spec_helper.rb')    { 'spec' }
end
