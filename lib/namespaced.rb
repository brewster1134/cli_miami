# root namespace class
#
class CliMiami
  # require & include core first
  require 'cli_miami/core'
  include CliMiami::Core

  # CliMiami library
  require 'cli_miami/error'
  require 'cli_miami/validation'
  require 'cli_miami/ask'
  require 'cli_miami/say'

  # Create a new custom preset
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
      description: I18n.t('cli_miami.core.no_description'),
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
end
