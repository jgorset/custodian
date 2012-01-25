require "custodian/cli/utilities"
require "custodian/cli/commands"

module Custodian
  module CLI
    extend Custodian::CLI::Utilities

    def self.run!(arguments)
      command, options = arguments.shift, arguments

      aliases = {
        "-h"         => "help",
        "--help"     => "help",
        "-v"         => "version",
        "--version"  => "version"
      }

      command = aliases[command] || command

      if c = Commands.find(command)
        c.call(options)
      else
        error "'#{command}' is not a custodian command. See 'custodian --help'."
      end
    end

  end
end
