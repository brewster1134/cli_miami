#
# 3rd party libraries & configuration
#
require 'active_support/core_ext/hash/conversions'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/string/inflections'
require 'i18n'
require 'readline'

# core object overrides
#
class Hash
  def to_s
    map do |k, v|
      "#{k}: #{v}"
    end.to_sentence
  end
end

# i18n
#
# load yml locales included in the cli miami gem
#   [PATH TO GEMS]/cli_miami/i18n/en.yml
I18n.load_path += Dir["#{File.dirname(__FILE__)}/../i18n/*.yml"]
# load locale in current directory named `i18n.yml`
#   ./i18n.yml
I18n.load_path += Dir['./i18n.yml']
# load locales in the folder `i18n` in the current directory
#   ./i18n/en.yml
I18n.load_path += Dir['./i18n/*.yml']

# readline
#
Readline.completion_append_character = '/'

# creates Boolean type that true/false inherit
# this allows true/false to respond to a single Boolean class to check for
#
# rubocop:disable Style/Documentation
module Boolean; end
class TrueClass; include Boolean; end
class FalseClass; include Boolean; end
# rubocop:enable Style/Documentation

# global configuration and setup
#
module CliMiami::Core
  BOOLEAN_TRUE_VALUES = %w(true t yes y).freeze
  BOOLEAN_FALSE_VALUES = %w(false f no n).freeze

  # keys:   type values allowed through the API
  # values: type used to validate internally in the Validation class
  TYPE_MAP = {
    array:      :array,
    boolean:    :boolean,
    dir:        :file,
    directory:  :file,
    file:       :file,
    fixnum:     :fixnum,
    float:      :float,
    folder:     :file,
    hash:       :hash,
    integer:    :fixnum,
    list:       :array,
    number:     :fixnum,
    object:     :hash,
    path:       :file,
    range:      :range,
    string:     :string,
    symbol:     :symbol
  }.freeze

  # default presets
  # rubocop:disable Style/ClassVars
  @@presets = {
    cli_miami_fail: {
      color: :red
    },
    cli_miami_success: {
      color: :green
    }
  }
  # rubocop:enable Style/ClassVars
end
