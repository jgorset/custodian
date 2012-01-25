require "custodian/cli/utilities"
require "custodian/cli/commands"

module Custodian
  
  # <tt>Custodian::CLI</tt> encapsulates Custodian's command-line interface.
  module CLI
    extend Custodian::CLI::Utilities

    def self.run!(arguments)
      command, options = arguments.shift, arguments

      unless command
        usage
        exit 1
      end

      if c = Commands.find(command)
        c.invoke(options)
      else
        error "'#{command}' is not a custodian command. See 'custodian --help'."
      end
    end

  end
end
