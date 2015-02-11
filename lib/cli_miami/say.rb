#
# class CliMiami::Say
#
require 'term/ansicolor'

class String
  include Term::ANSIColor
end

class CliMiami::S
  #
  # @param options [Symbol or Hash] options can be preset symbol, or a hash of options.
  #
  # By preset [Symbol[...
  # [symbol]  Uses defined preset name
  #
  # By options [Hash]...
  # color:        => [symbol]             See README for ansi color codes
  # bgcolor:      => [symbol]             See README for ansi color codes
  # style:        => [symbol]             See README for ansi style codes
  # justify:      => [center|ljust|rjust] The type of justification to use
  # padding:      => [integer]            The maximum string size to justify text in
  # indent:       => [integer]            The number of characters to indent
  # newline:      => [boolean]            True if you want a newline after the output
  # overwrite:    => [boolean]            True if you want the next line to overwrite the current line
  #
  # @return
  #
  def self.ay text = '', options = {}
    original_text = text

    # set default options
    @options = {
      :style => [],
      :newline => true
    }

    # merge preset options
    if options.is_a? Symbol
      @options.merge! CliMiami.presets[options]
    elsif preset = options.delete(:preset)
      @options.merge! CliMiami.presets[preset]
    end

    # merge remaining options
    if options.is_a? Hash
      @options.merge! options
    end

    # convert single style into an array for processing
    if !@options[:style].is_a? Array
      @options[:style] = [@options[:style]]
    end

    # Justify/Padding options
    if @options[:justify] && @options[:padding]
      text = text.send @options[:justify], @options[:padding]
    end

    # Set foreground color
    if @options[:color]
      # if bright style is passed, use the bright color variation
      text = if @options[:style].delete :bright
        text.send("bright_#{@options[:color]}")
      else
        text.send(@options[:color])
      end
    end

    # Set background color
    if @options[:bgcolor]
      text = text.send("on_#{@options[:bgcolor]}")
    end

    # Apply all styles
    @options[:style].each do |style|
      text = text.send(style)
    end

    # Indent
    if @options[:indent]
      text = (' ' * @options[:indent]) + text
    end

    # Flag text to be overwritten by next text written
    if @options[:overwrite]
      text = "#{text}\r"
    end

    # Determine if a newline should be used
    if !@options[:newline] || @options[:overwrite]
      $stdout.print text
    else
      $stdout.puts text
    end

    # return original text
    return original_text
  end
end
