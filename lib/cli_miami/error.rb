#
# Build custom i18n error messages
#
class CliMiami::Error
  attr_reader :message

private

  def initialize value, options, *error_keys
    options[:value] = convert_type_to_string value
    options[:allowed_values] = allowed_values options

    @message = i18n_lookup_keys(options, *error_keys) || 'Unknown Error'
  end

  # convert value from it's type, to a user friendly string
  # with core ruby objects, we create a `.to_string` method instead of changes the default `.to_s` method
  #
  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def convert_type_to_string value
    case value

    when Array
      value.map do |e|
        if e.nil? || e == ''
          I18n.t 'cli_miami.core.empty'
        else
          convert_type_to_string e
        end
      end.to_sentence

    when Hash
      value.map do |k, v|
        v = if v.nil? || v == ''
          I18n.t 'cli_miami.core.empty'
        else
          convert_type_to_string v
        end

        "#{k}: #{v}"
      end.to_sentence

    when Range
      "#{value.min}-#{value.max}"

    when File
      File.expand_path value

    else
      value.to_s

    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  # get allowed values based on validation details
  #
  # rubocop:disable Metrics/MethodLength
  def allowed_values options
    case options[:type]
    when :array, :hash
      if options[:value_options]
        allowed_values options[:value_options]
      else
        "#{options[:min]}-#{options[:max]}"
      end

    when :boolean
      all_boolean_values = CliMiami::BOOLEAN_TRUE_VALUES + CliMiami::BOOLEAN_FALSE_VALUES
      all_boolean_values.to_sentence

    when :fixnum, :float, :multiple_choice, :range, :string, :symbol
      "#{options[:min]}-#{options[:max]}"

    when :regexp
      options[:regexp].inspect

    else
      '?'
    end
  end
  # rubocop:enable Metrics/MethodLength

  # build an i18n dot notation string to use for lookup in the language yaml
  #
  # rubocop:disable Metrics/MethodLength
  def i18n_lookup_keys options, *error_keys
    # check for type specific error first, then look for generic errors
    i18n_lookup(
      options,
      'cli_miami',
      'errors',
      options[:type].to_s,
      *error_keys
    ) || i18n_lookup(
      options,
      'cli_miami',
      'errors',
      *error_keys
    )
  end
  # rubocop:enable Metrics/MethodLength

  # use i18n dot notation keys to lookup string
  #
  def i18n_lookup options, *keys
    i18n_string = keys.flatten.compact.each(&:to_s).join('.')

    # check if value exists, and translate it
    if I18n.exists? i18n_string
      # format description for i18n messages
      if options[:description]
        options[:description] = ' (' << options[:description] << ')'
      end

      I18n.t i18n_string, options
    end
  end
end
