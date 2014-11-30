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
    options = {
      :readline => false,
    }.merge(options)

    CliMiami::S.ay question, options

    output = if options[:readline]
      Readline.readline(@@prompt).chomp('/')
    else
      CliMiami::S.ay @@prompt, :newline => false
      $stdin.gets
    end.rstrip

    yield output if block
  end

  def self.prompt; @@prompt; end
  def self.prompt= prompt
    @@prompt = prompt
  end
end
