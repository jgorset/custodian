require "custodian/cli/utilities"
require "custodian/cli/commands"

module Custodian
  
  # <tt>Custodian::CLI</tt> encapsulates Custodian's command-line interface.
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
        c.invoke(options)
      else
        error "'#{command}' is not a custodian command. See 'custodian --help'."
      end
    end

  end
end
