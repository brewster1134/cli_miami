#
# class CliMiami::Ask
#

require 'readline'

class CliMiami::A
  @@prompt = '>>> '

  # See documentation for CliMiami::S.ay
  # The same options are accepted
  #
  def self.sk question, options = {}, &block
    # set default options
    @options = {
      :readline => false
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

    CliMiami::S.ay question, @options

    output = if @options[:readline]
      Readline.readline(@@prompt).chomp('/')
    else
      CliMiami::S.ay @@prompt, :newline => false
      $stdin.gets
    end.rstrip

    # return response if no block is passed
    if block_given?
      yield output
    else
      return output
    end
  end

private

  def self.prompt; @@prompt; end
  def self.prompt= prompt
    @@prompt = prompt
  end
end
