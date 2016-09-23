require 'term/ansicolor'

# Reopen String class for ANSI color support
class String
  include Term::ANSIColor
end

#
# class CliMiami::S.ay
#
class CliMiami::S
  # S.ay API method
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
  # justify:      => [center|left|right]  The type of justification to use
  # padding:      => [integer]            The maximum string size to justify text in
  # indent:       => [integer]            The number of characters to indent
  # newline:      => [boolean]            True if you want a newline after the output
  # overwrite:    => [boolean]            True if you want the next line to overwrite the current line
  #
  # @return
  #
  def self.ay text = '', options = {}
    # set default options
    options = CliMiami.get_options options
    new text, options
  end

private

  def initialize text, options
    @text = text.to_s
    @options = options

    # formatter methods
    modify_justification!
    modify_text_color!
    modify_background_color!
    modify_styles!
    modify_indentation!
    modify_overwrite!

    # render formatted text to user
    print_output
  end

  # Justify/Padding options
  # must convert option to support String class method
  def modify_justification!
    justify =
      case @options[:justify]
      when :center then :center
      when :right then :rjust
      else :ljust
      end

    @text = @text.send justify, @options[:padding]
  end

  # Set foreground color
  def modify_text_color!
    return unless @options[:color]

    # if bright style is passed, use the bright color variation
    @text = if @options[:style].delete :bright
      @text.send "bright_#{@options[:color]}"
    else
      @text.send @options[:color]
    end
  end

  # Set background color
  def modify_background_color!
    @text = @text.send("on_#{@options[:bgcolor]}") if @options[:bgcolor]
  end

  # Apply all styles
  def modify_styles!
    @options[:style].each do |style|
      @text = @text.send(style)
    end
  end

  # Indent
  def modify_indentation!
    @text = (' ' * @options[:indent]) + @text if @options[:indent]
  end

  # Flag text to be overwritten by next text written
  def modify_overwrite!
    @text = "#{@text}\r" if @options[:overwrite]
  end

  # finally render the formatted text to the screen
  def print_output
    # Determine if a newline should be used
    if !@options[:newline] || @options[:overwrite]
      $stdout.print @text + ' '
    else
      $stdout.puts @text
    end
  end
end
