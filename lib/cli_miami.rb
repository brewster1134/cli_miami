# Load dependencies
#
require 'active_support/core_ext/hash/conversions'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/string/inflections'
require 'i18n'
require 'readline'

# Add custom Hash methods
#
class Hash
  def to_cli_miami_string
    map do |k, v|
      "#{k}: #{v}"
    end.to_sentence
  end
end

# Add custom String methods
#
class String
  def method_missing method, *args
    method_string = method.to_s.dup

    if method_string.slice! 'cli_miami_'
      method_symbol = method_string.to_sym
      preset = CliMiami.presets[method_symbol] || {}
      options = preset.merge args[0] || {}

      CliMiami::S.ay self, options
    else
      super
    end
  end

  def respond_to_missing? method, _args
    method =~ /^cli_miami_/ || super
  end
end

# I18n
#
I18n.load_path += Dir[File.join('i18n', '*.yml')]
I18n.locale = ENV['LANG'].split('.').first.downcase
I18n.reload!

# Readline
#
Readline.completion_append_character = '/'

# Creates Boolean type that true/false inherit
# This allows true/false to respond to a single Boolean class to check for
#
# rubocop:disable Style/Documentation
module Boolean; end
class TrueClass; include Boolean; end
class FalseClass; include Boolean; end
# rubocop:enable Style/Documentation

# Create Cli Miami namespace and load library
#
module CliMiami
  BOOLEAN_TRUE_VALUES = %w(true t yes y).freeze
  BOOLEAN_FALSE_VALUES = %w(false f no n).freeze

  # keys:   type values allowed through the API
  # values: type used to validate internally in the Validation class
  TYPE_MAP = {
    array:            :array,
    boolean:          :boolean,
    dir:              :file,
    directory:        :file,
    file:             :file,
    fixnum:           :fixnum,
    float:            :float,
    folder:           :file,
    multiple_choice:  :multiple_choice,
    hash:             :hash,
    integer:          :fixnum,
    list:             :array,
    number:           :fixnum,
    object:           :hash,
    path:             :file,
    range:            :range,
    string:           :string,
    symbol:           :symbol
  }.freeze

  # default presets
  # rubocop:disable Style/ClassVars
  @@presets = {
    cli_miami_fail: {
      indent: 2,
      color: :red,
      style: [:bold, :underline]
    },
    cli_miami_instruction: {
      color: :green,
      style: :bold
    },
    cli_miami_instruction_sub: {
      indent: 2,
      color: :green
    },
    cli_miami_success: {
      color: :green,
      style: [:bold, :underline]
    },
    cli_miami_update: {
      indent: 2,
      color: :cyan
    }
  }
  # rubocop:enable Style/ClassVars

  # Create a new custom preset
  #
  def self.set_preset type, options
    raise ArgumentError, 'Preset must be a hash of options' unless options.is_a? Hash

    # extend preset if it exists
    extend_preset = options.delete(:preset)
    if extend_preset && @@presets[extend_preset.to_sym]
      extend_preset_options = @@presets[extend_preset.to_sym]
      options = extend_preset_options.merge! options
    end

    # set options to global var
    @@presets[type] = options
  end

  # getter for the presets
  #
  def self.presets
    @@presets
  end

  # build an options hash from preset options and/or additional options
  #
  # build shared validation hash object
  #
  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  def self.get_options user_options = {}
    # lookup preset if passed in as a symbol, or as a :preset key in an options hash
    if user_options.is_a? Hash
      user_options.deep_symbolize_keys!
      options = @@presets[user_options.delete(:preset)] || {}
      options.deep_merge! user_options
    else
      options = @@presets[user_options.to_sym] || {}
    end

    # make sure all keys are symbols
    options.deep_symbolize_keys!

    # set defaults
    options.reverse_merge!(
      description: nil,
      max: Float::INFINITY,
      min: options.delete(:required) ? 1 : 0,
      newline: true,
      justify: :left,
      padding: 0,
      preset: nil,
      regexp: //,
      style: [],
      type: :string
    )

    # prepare style array
    options[:style] = [options[:style]].flatten

    # lookup type in type map
    options[:type] = TYPE_MAP[options[:type].to_sym] || :string

    # convert range to min/max values
    range = options.delete(:range)
    if range
      options[:min] = range.min
      options[:max] = range.max
    end

    # convert length to min/max values
    length = options.delete(:length)
    if length
      options[:min] = options[:max] = length
    end

    # if value options are set, apply the same treatment to them
    value_options = options[:value_options]
    if value_options
      options[:value_options] = get_options value_options
      options[:value_options][:description] = options[:description]
    end

    options
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

  def self.version
    CliMiami::VERSION
  end
end

# Load Cli Miami library
require 'cli_miami/ask'
require 'cli_miami/error'
require 'cli_miami/metadata'
require 'cli_miami/say'
require 'cli_miami/validation'
