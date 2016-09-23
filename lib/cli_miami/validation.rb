#
# validates user input values against their expected type
#
class CliMiami::Validation
  attr_reader :error, :valid, :value

  # validates string provided by the user
  #
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def initialize initial_value, options
    @options = CliMiami.get_options options
    @value = initial_value
    @valid = true
    @error = nil

    # convert
    # only attempt to convert strings
    # if not a string, skip conversion and go straight to validation
    if initial_value.is_a? String
      begin
        @value = send("convert_string_to_#{options[:type]}", initial_value, @options)
      rescue
        @error = CliMiami::Error.new(initial_value, @options, :convert).message
        @valid = false
      end
    end

    return if @value.nil? || !@valid

    # validate
    begin
      # keep all values the same unless validation fails
      send "validate_#{options[:type]}", @value, @options
    rescue => error
      # if validation fails, set values, including error to the specific validation error
      @error = error.to_s
      @valid = false
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def valid?
    @valid
  end

private

  #
  # TYPE CONVERSIONS
  # all type conversions must raise an exception if they fail
  #
  def convert_string_to_boolean string, _options
    return true if CliMiami::BOOLEAN_TRUE_VALUES.include? string.downcase
    return false if CliMiami::BOOLEAN_FALSE_VALUES.include? string.downcase
    raise
  end

  def convert_string_to_file string, _options
    return string if string.empty?
    File.absolute_path(File.expand_path(string))
  end

  # the `Integer` class fails when passed a float, so we convert to a float and back to an integer
  # this allows users to enter a float when an integer is requested without it failing
  #
  def convert_string_to_fixnum string, _options
    Integer Float(string).to_i
  end

  def convert_string_to_float string, _options
    Float string
  end

  # multiple choice strings are also integers
  alias_method :convert_string_to_multiple_choice, :convert_string_to_fixnum

  def convert_string_to_range string, _options
    range_array = string.split('..').map { |i| Float(i) }.sort

    # check that array has 2 supported range values
    return Range.new(range_array[0], range_array[1]) if range_array.length == 2
    raise
  end

  # pass-through method for converting a string to a string
  def convert_string_to_string string, _options
    string
  end

  def convert_string_to_symbol string, _options
    raw_symbol = string.underscore.to_sym

    # if the symbol is quoted, remove some characters and try converting again
    if raw_symbol.inspect =~ /\:\"/
      # convert non a-z to underscores, then remove duplicate or leading/trailing underscores
      converted_symbol = raw_symbol.to_s.gsub(/[^a-z]/, '_').gsub(/\_+/, '_').gsub(/^_/, '').gsub(/_$/, '').to_sym

      # if symbol was converted, return it, otherwise raise an error
      return converted_symbol unless converted_symbol.empty?
      raise
    end

    raw_symbol
  end

  #
  # TYPE VALIDATORS
  # all type validators must raise an exception if they fail
  #

  # validate the value is within the min and max values
  #
  def validate_length value, length, options
    return if (options[:min]..options[:max]).cover? length

    options[:value_length] = length

    # replace empty values with i18n `empty` string
    value = I18n.t('cli_miami.core.empty') if value.respond_to?(:empty?) && value.empty?

    raise CliMiami::Error.new(value, options, :length).message
  end

  # validate that the value passes a regular expression
  #
  def validate_regexp value, options
    unless value =~ options[:regexp]
      raise CliMiami::Error.new(value, options, :regexp).message
    end
  end

  def validate_array array, options
    validate_length array, array.length, options
  end

  # no validation needed for boolean types
  # type conversion is all the validation required
  def validate_boolean boolean, options
  end

  def validate_file file, options
    raise if file.empty?
    File.new File.expand_path file
  rescue
    raise CliMiami::Error.new(file, options, :validate).message
  end

  def validate_fixnum fixnum, options
    validate_length fixnum, fixnum, options
  end

  def validate_float float, options
    validate_length float, float, options
  end

  # rubocop:disable Metrics/AbcSize
  def validate_hash hash, options
    hash.deep_symbolize_keys!

    validate_length hash, hash.keys.length, options

    # return if no value options are set
    value_options = options[:value_options]
    return unless value_options
    return unless value_options[:keys]

    # validate required keys are set
    missing_keys = Set.new(value_options[:keys].map(&:to_sym)) - Set.new(hash.keys)
    value_options[:missing_values] = missing_keys.to_a.to_sentence

    unless missing_keys.empty?
      raise CliMiami::Error.new(hash, options, :keys).message
    end
  end
  # rubocop:enable Metrics/AbcSize

  def validate_multiple_choice selections, options
    validate_length selections, selections.length, options
  end

  def validate_range range, options
    range_diff = (range.max - range.min) + 1
    validate_length range, range_diff, options
  end

  def validate_string string, options
    validate_length string, string.length, options
    validate_regexp string, options
  end

  def validate_symbol symbol, options
    validate_length symbol, symbol.to_s.length, options
    validate_regexp symbol, options
  end
end
