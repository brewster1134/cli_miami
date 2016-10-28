[![gem version](https://badge.fury.io/rb/cli_miami.svg)](https://badge.fury.io/rb/cli_miami)
[![dependencies](https://gemnasium.com/brewster1134/cli_miami.svg)](https://gemnasium.com/brewster1134/cli_miami)
[![docs](http://inch-ci.org/github/brewster1134/cli_miami.svg?branch=master)](http://inch-ci.org/github/brewster1134/cli_miami)
[![build](https://travis-ci.org/brewster1134/cli_miami.svg?branch=master)](https://travis-ci.org/brewster1134/cli_miami)
[![coverage](https://coveralls.io/repos/brewster1134/cli_miami/badge.svg?branch=master)](https://coveralls.io/r/brewster1134/cli_miami?branch=master)
[![code climate](https://codeclimate.com/github/brewster1134/cli_miami/badges/gpa.svg)](https://codeclimate.com/github/brewster1134/cli_miami)

# CLI Miami
###### A colorful & feature-rich alternative to gets & puts for your command line app
---

Build a rich command line experience for your app. CLI Miami lets you easily display clear & colorful information to your user, and prompting your user to enter information with a clear and concise approach. Easily request arrays, hashes, booleans, integers, floats, ranges, symbols, and even multiple choice. Additionally provide validation rules like minimum and maximum length, or regexp matching.

---
#### Install
```shell
gem install cli_miami
```

---
_Gemfile_
```ruby
# For the name-spaced methods CliMiami::A.sk & CliMiami::S.ay...
gem 'cli_miami'

# For the friendlier global methods A.sk & S.ay...
gem 'cli_miami', require: 'cli_miami/global'
```

#### S.ay
###### Display information to the user
---

###### `S.ay` accepts a string as the first argument for the text to show, followed by a variety of styling options
_* see Styling Options below_

```ruby
S.ay 'Hello World', color: :red
```

If you want to mix styles on a single line, you can set newline to false

```ruby
S.ay 'Hello ', color: :red, newline: false
S.ay 'World', color: :blue
```

#### A.sk
###### Request information from the user
---

###### `A.sk` accepts the same styling options as `S.ay`
_* see Styling Options below_

There are 2 ways to handle the user's response.

```ruby
# passing the response to a block...
A.sk 'What is your name?', color: :yellow do |response|
  S.ay "Hello #{response}!", style: :bold
end

# returning the response through the `value` method
response = A.sk 'What is your name?', color: :yellow
S.ay "Hello #{response.value}!", style: :bold
```

###### `A.sk` accepts an additional :type option for requesting specific values

```ruby
A.sk 'What is your age?', type: :number
```

#### Type Options

```ruby
:array
:list             # Prompt for multiple responses for a single request

:boolean          # Prompt for true/false response

:dir
:directory
:file
:folder
:path             # Prompt for a local directory path

:fixnum
:integer
:number           # Prompt for an integer

:float            # Prompt for a decimal

:multiple_choice  # Prompt for values from a defined list of choices (see Validation Options below)

:hash
:object           # Prompt for key/value pairs

:range            # Prompt for a beginning and end numerical values

:string           # Prompt for text

:symbol           # Prompt for text that can convert to a proper ruby symbol
```

###### `A.sk` accepts additional validation options to further refine the user's response
_* validation options vary depending on the :type_

```ruby
A.sk 'What is your age?', type: :number, min: 18, max: 99
```

#### Validation Options

```ruby
:array
:list             
  :min            # The least amount of responses allowed
  :max            # The most amount of responses allowed
  :value_options  # An optional hash of Type Options & Validation Options to be applied to each response

:boolean
  'true'
  't'
  'yes'
  'y'             # The allowed values to represent `true`

  'false'
  'f'
  'no'
  'n'             # The allowed values to represent `false`

:dir
:directory
:file
:folder
:path             # Must be a valid, existing path to a local file or folder

:fixnum
:float            
:integer
:number           
  :min            # The lowest numerical value allowed
  :max            # The highest numerical value allowed

:multiple_choice
  :choices        # An Array or Hash of allowed values to choose from
                  # ['option 1', 'option 2', 'option 3']
                  # { one: 'option 1', two: 'option 2', three: 'option 3' }
  :min            # The least amount of responses allowed
  :max            # The most amount of responses allowed

:hash
:object           
  :keys           # An Array of keys that require a response
  :min            # The least amount of key/value responses allowed
  :max            # The most amount of key/value responses allowed
  :value_options  # An optional hash of Type Options & Validation Options to be applied to each response value

:range            
  :min            # The smallest range of numerical values allowed
  :max            # The largest range of numerical values allowed

:string           
  :min            # The least amount of characters allowed
  :max            # The most amount of characters allowed
  :regexp         # A regular expression the response must match

:symbol           
  :min            # The least amount of characters allowed
  :max            # The most amount of characters allowed
  :regexp         # A regular expression the response must match
```

#### Styling Options
Both `S.ay` and `A.sk` suport the same styling options

```ruby
color:      [symbol]             # See ansi color codes below
bgcolor:    [symbol]             # See ansi color codes below
style:      [symbol]             # See ansi style codes below. Can accept multiple styles as an array
justify:    [center|left|right]  # The type of justification to use
padding:    [integer]            # The maximum string size to justify text in
indent:     [integer]            # The number of characters to indent
newline:    [boolean]            # Set to true if you want a newline after the output
```

###### ANSI Color Codes

```ruby
:black
:red
:green
:yellow
:blue
:magenta
:cyan
:white
```

###### ANSI Style Codes

```ruby
:bold
:bright
:underline
:negative   # Swap foreground color with background color
```

### Development & Testing

```shell
# clone repo
git clone https://github.com/brewster1134/cli_miami.git
cd cli_miami

# install dependencies
bundle install

# run watcher for linting and tests
bundle exec guard
```

[![WTFPL](http://www.wtfpl.net/wp-content/uploads/2012/12/wtfpl-badge-4.png)](http://www.wtfpl.net)
