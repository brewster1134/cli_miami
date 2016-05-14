[![gem version](https://badge.fury.io/rb/cli_miami.svg)](https://badge.fury.io/rb/cli_miami)
[![dependencies](https://gemnasium.com/brewster1134/CLI-Miami.svg)](https://gemnasium.com/brewster1134/CLI-Miami)
[![docs](http://inch-ci.org/github/brewster1134/CLI-Miami.svg?branch=master)](http://inch-ci.org/github/brewster1134/CLI-Miami)
[![build](https://travis-ci.org/brewster1134/CLI-Miami.svg?branch=master)](https://travis-ci.org/brewster1134/CLI-Miami)
[![coverage](https://coveralls.io/repos/brewster1134/CLI-Miami/badge.svg?branch=master)](https://coveralls.io/r/brewster1134/CLI-Miami?branch=master)
[![code climate](https://codeclimate.com/github/brewster1134/CLI-Miami/badges/gpa.svg)](https://codeclimate.com/github/brewster1134/CLI-Miami)
[![omniref](https://www.omniref.com/github/brewster1134/CLI-Miami.png)](https://www.omniref.com/github/brewster1134/CLI-Miami)

# CLI Miami
A feature rich alternative for `gets` and `puts` for your cli interface

```shell
gem install cli_miami
```

_Gemfile_
```ruby
# For the name-spaced methods CliMiami::A.sk & CliMiami::S.ay...
gem 'cli_miami'

# For the friendlier global methods A.sk & S.ay...
gem 'cli_miami', require: 'cli_miami/global'
```

#### S.ay
`S.ay` accepts 2 arguments, a string, and a variety of options
_* see supported options below_

```ruby
S.ay 'Hello World', :color => :red
```

Sometimes you want to have multiple styles on a single line.  There are 2 ways to do this.

The multi-line way using `:newline => false`
```ruby
S.ay 'Hello ', :color => :red, :newline => false
S.ay 'World', :color => :blue
```

Or on a single line using ANSI codes as methods. *All the ANSI color and style codes listed below can be used*
```ruby
S.ay "#{'Hello'.red} #{'World'.blue}"
```

#### A.sk
`A.sk` accepts the same arguments as `S.say`, with additional support for a block that passes the users response

```ruby
A.sk 'What is your name?', :color => :yellow do |response|
  S.ay "#{response} smells!", :style => :bold
end
```

#### Options
Both `S.ay` and `A.sk` suport the same options

```ruby
color:      => [symbol]             # See ansi color codes below
bgcolor:    => [symbol]             # See ansi color codes below
style:      => [symbol]             # See ansi style codes below. Can accept multiple styles as an array
justify:    => [center|left|right]  # The type of justification to use
padding:    => [integer]            # The maximum string size to justify text in
indent:     => [integer]            # The number of characters to indent
newline:    => [boolean]            # True if you want a newline after the output
overwrite:  => [boolean]            # True if you want the next line to overwrite the current line
```

###### ANSI Color Codes
* `:black`
* `:red`
* `:green`
* `:yellow`
* `:blue`
* `:magenta`
* `:cyan`
* `:white`

###### ANSI Style Codes
* `:bold`
* `:bright`
* `:underline`
* `:negative` _Swap foreground color with background color_

### Development & Testing

```shell
yuyi -m https://raw.githubusercontent.com/brewster1134/CLI-Miami/master/yuyi_menu
bundle install
bundle exec guard
```

[![WTFPL](http://www.wtfpl.net/wp-content/uploads/2012/12/wtfpl-badge-4.png)](http://www.wtfpl.net)
