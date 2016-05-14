#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path('./lib')
require './lib/cli_miami'

# a = A.sk 'enter array', type: :array
# a = A.sk 'enter boolean', type: :boolean
# a = A.sk 'enter file', type: :file
# a = A.sk 'enter fixnum', type: :fixnum
# a = A.sk 'enter float', type: :float
# a = A.sk 'enter hash', type: :hash

# RANGE
# a = A.sk 'enter range', type: :range
# a = A.sk 'enter range', type: :range, min: 4

# MULTIPLE CHOICE
# a = A.sk 'enter multiple choice', type: :multiple_choice, choices: ['option 1', 'option 2']

# a = A.sk 'enter string', type: :string
# a = A.sk 'enter symbol', type: :symbol

puts a.value.inspect
