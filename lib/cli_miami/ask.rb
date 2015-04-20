#
# class CliMiami::Ask
#

require 'readline'
Readline.completion_append_character = '/'

class CliMiami::A
  extend CliMiami::Validation

  @@prompt = '>>> '

  # See documentation for CliMiami::S.ay
  # The same options are accepted
  #
  def self.sk question, options = {}, &block
    CliMiami::S.ay question, options

    readline = options.delete(:readline) rescue false
    output = if readline
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
