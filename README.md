# CLI Miami
A feature rich alternative for `gets` and `puts` for your cli interface

_Gemfile_
```ruby
# This exposes the shortened API for `A.sk` and `S.ay`
gem 'cli_miami'

# if you need the API to be namespaced (`CliMiami::A.sk`, `CliMiami::S.ay`)
gem 'cli_miami', :require => :namespaced
```

#### S.ay
`S.ay` accepts 2 arguments, a string, and a variety of options
_* see supported options below_

```ruby
S.ay 'Hello World', :color => :red
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

https://github.com/flori/term-ansicolor/tree/master/lib/term/ansicolor/attribute

```ruby
color:      => [symbol]             # See ansi color codes below
bgcolor:    => [symbol]             # See ansi color codes below
style:      => [symbol]             # See ansi style codes below. Can accept multiple styles as an array
justify:    => [center|ljust|rjust] # The type of justification to use
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
gem install cli_miami
yuyi -m https://raw.githubusercontent.com/brewster1134/turple/master/yuyi_menu
bundle install
bundle exec guard
```
