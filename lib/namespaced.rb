# This is the primary initializer

class CliMiami
  require 'cli_miami/ask'
  require 'cli_miami/say'

  # default presets
  @@presets = {
    :fail => {
      :color => :red,
      :style => :bold
    },
    :warn => {
      :color => :yellow,
      :style => :bold
    },
    :success => {
      :color => :green,
      :style => :bold
    }
  }

  # Returns all presets
  def self.presets
    @@presets
  end

  # Create a new custom preset
  def self.set_preset type, options
    raise 'Preset must be a hash of options' unless options.is_a? Hash
    @@presets[type] = options
  end
end
